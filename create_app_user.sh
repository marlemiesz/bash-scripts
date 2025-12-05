#!/bin/sh

# Check if script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

USERNAME="app"

# Create user
useradd -m -s /bin/bash $USERNAME

if [ $? -eq 0 ]; then
    echo "User '$USERNAME' created successfully"
else
    echo "Failed to create user '$USERNAME'"
    exit 1
fi

# Add user to sudo group
usermod -aG sudo $USERNAME
echo "User '$USERNAME' added to sudo group"

# Set password
echo "Set password for '$USERNAME':"
passwd $USERNAME
