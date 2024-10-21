#!bin/bash

function display_usage {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -c, --create     Create a new user account."
    echo "  -d, --delete     Delete an existing user account."
    echo "  -r, --reset      Reset password for an existing user account."
    echo "  -l, --list       List all user accounts on the system."
    echo "  -h, --help       Display this help and exit."
}
display_usage
function create_user {
    read -p "Enter the new username: " username
    if id "$username" &>/dev/null; then
        echo "Error: The username '$username' already exists. Please choose a different username."
    else
        read -p "Enter the password for $username: " password
        useradd -m -p "$password" "$username"
        echo "User account '$username' created successfully."
    fi
}
function delete_user {
    read -p "Enter the username to delete: " username
    if id "$username" &>/dev/null; then
        userdel -r "$username"
        echo "User account '$username' deleted successfully."
    else
        echo "Error: The username '$username' does not exist. Please enter a valid username."
    fi
}
function reset_password {
    read -p "Enter the username to reset password: " username
    if id "$username" &>/dev/null; then
        read -p "Enter the new password for $username: " password
        echo "$username:$password" | chpasswd
        echo "Password for user '$username' reset successfully."
    else
        echo "Error: The username '$username' does not exist. Please enter a valid username."
    fi
}
function list_users {
    echo "User accounts on the system:"
    cat /etc/passwd | awk -F: '{ print "- " $1 " (UID: " $3 ")" }'
}
echo "Enter Your Choice:"
read usr_input

case "$usr_input" in
   "1")
        create_user   # Call the create_user function
        ;;
    2)
        delete_user   # Call the delete_user function
        ;;
    3)
        reset_password # Call the reset_password function
        ;;
    4)
        list_users    # Call the list_users function
        ;;
    5)
        display_usage  # Call the display_usage function
        ;;
    *)
        echo "Error: Invalid option '$user_input'. Use '--help' to see available options."
        exit 1
        ;;
esac
