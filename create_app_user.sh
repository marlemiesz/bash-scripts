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

# Setup SSH key
SSH_DIR="/home/$USERNAME/.ssh"
mkdir -p $SSH_DIR
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDn5ei0DTa2gfnkqjXggeqZd+LPdW4U/+o1XQL//CFNybPfIF2sR828cNuLAh4TmWnzHvR5zQAWYzdfK++ofn0EbfGvbnHubjJOd42Ayph55m+9v7oW1EDIdMx4VWSJ7OZ6DxINj1IIsB3u3fXUEegx7MGPo4zZDcpjy2YdBQ42PKI5KVaknlLeDU0t+jr3dRUIuNJgA3l18qtc5jTXH23BhpV/+qt/hA8fme/RYNvUEFE7q07sEpEuQGgE2hkx79jDFmhuBZz8xRtoYMnKDwIGpNkkPZX6ZV3wKOOxzwO+RMzh/O//O2veBWm6qSmKJHGRt9wkd3GBreyrOJ3beWuhMp8sOgSL5tb2OK6LdN3jeS8PJBBfC1R1HexuQIJdKhRQw32L3MJCIxIzAkiS6v7cXfey54WSayTcbOxqAidLQcW2Rk6ZBuwDEnx7vLBD4nxD8F9MAJ3nzvKvNCs/7ZPFGll4Jh2P0HrY/OxMDS+og9xfT4gyXr7UfK0vBcZWxmc= marle@LAPTOP-ICR0NFMB" > $SSH_DIR/authorized_keys
chown -R $USERNAME:$USERNAME $SSH_DIR
chmod 700 $SSH_DIR
chmod 600 $SSH_DIR/authorized_keys
echo "SSH key added to authorized_keys"
