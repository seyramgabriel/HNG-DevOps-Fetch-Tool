#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update package lists
echo "Updating package lists..."
sudo apt update

# Check for Python3
if command_exists python3; then
    echo "Python3 is already installed."
else
    echo "Python3 not found. Installing Python3..."
    sudo apt install -y python3
fi

# Check for pip3
if command_exists pip3; then
    echo "pip3 is already installed."
else
    echo "pip3 not found. Installing pip3..."
    sudo apt install -y python3-pip
fi

# Check for Docker
if command_exists docker; then
    echo "Docker is already installed."
else
    echo "Docker not found. Installing Docker..."
    #sudo apt install -y docker.io
    # Update system packages
    sudo apt-get update
    sudo apt-get upgrade

    # Install necessary packages
    sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

    # Add Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Add Docker APT repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update package database
    sudo apt-get update

    # Install Docker
    sudo apt-get install docker-ce docker-ce-cli containerd.io

    # Verify Docker installation
    sudo docker run hello-world

    # Optional: Manage Docker as a non-root user
    sudo usermod -aG docker $USER

    # Download Docker Compose binary
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Apply executable permissions
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Check for Nginx
if command_exists nginx; then
    echo "Nginx is already installed."
else
    echo "Nginx not found. Installing Nginx..."
    sudo apt install -y nginx
    sudo systemctl start nginx
fi

# Install Python packages
# echo "Installing Python packages..."
# pip3 install -r requirements.txt

# Copy the systemd service file to the appropriate location
echo "Setting up systemd service..."
sudo cp devopsfetch.service /etc/systemd/system/

# Reload systemd to recognize the new service
echo "Reloading systemd..."
sudo systemctl daemon-reload

# Enable the service to start on boot
echo "Enabling devops_fetch service to start on boot..."
sudo systemctl enable devopsfetch.service

# Start the service
echo "Starting devopsfetch service..."
sudo systemctl start devopsfetch.service

echo "Installation complete."
