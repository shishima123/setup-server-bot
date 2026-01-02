#!/bin/bash

# Set timezone
TIMEZONE="Asia/Ho_Chi_Minh"

# Function to set the timezone and configure NTP
vutruso_configure_timezone_and_ntp() {
    # Set the timezone using timedatectl
    sudo timedatectl set-timezone $TIMEZONE

    # Verify the timezone change
    echo "Timezone has been set to: $(timedatectl | grep 'Time zone')"

    # Install and configure chrony
    if [ -f /etc/redhat-release ]; then
        # AlmaLinux (RHEL-based)
        sudo dnf install -y chrony
        sudo systemctl start chronyd
        sudo systemctl enable chronyd
    elif [ -f /etc/lsb-release ]; then
        # Ubuntu
        sudo apt update
        sudo apt install -y chrony
        sudo systemctl start chrony
        sudo systemctl enable chrony
    else
        echo "Unsupported OS. This script supports AlmaLinux and Ubuntu."
        exit 1
    fi

    # Enable NTP
    sudo timedatectl set-ntp true

    # Verify the NTP change
    echo "NTP has been enabled: $(timedatectl | grep 'NTP synchronized')"
}

# Execute the configuration function
vutruso_configure_timezone_and_ntp