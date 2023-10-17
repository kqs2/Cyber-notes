#!/bin/bash

# Update the package lists
sudo apt-get update

# Upgrade installed packages
sudo apt-get upgrade

# Install and configure Uncomplicated Firewall (UFW)
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

# Install and configure Fail2Ban
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Install and configure a basic intrusion detection system (rkhunter)
sudo apt install rkhunter -y
sudo rkhunter --update
sudo rkhunter --propupd

# Install and configure ClamAV for antivirus scanning
sudo apt install clamav clamav-daemon -y
sudo freshclam

# Enable automatic updates
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure -plow unattended-upgrades

# Set up automatic security updates
cat <<EOL | sudo tee /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOL

# Disable root login via SSH
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Display a message indicating that the system is now secure
echo "Security configuration completed."

# Uncomment the line below if you want to reboot the system
# sudo reboot
