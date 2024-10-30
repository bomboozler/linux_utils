#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Create a modprobe configuration file for NVIDIA DRM
MODPROBE_CONF="/etc/modprobe.d/nvidia-drm.conf"

# Add settings to the configuration file
{
    echo "options nvidia-drm modeset=1"
} > "$MODPROBE_CONF"

echo "NVIDIA DRM configuration has been set to enable modeset."

# Create a modprobe configuration file to disable GSP firmware
GSP_CONF="/etc/modprobe.d/nvidia-gsp.conf"

# Add settings to disable GSP firmware
{
    echo "options nvidia NVreg_EnableGpuFirmware=0"
} > "$GSP_CONF"

echo "GSP firmware has been disabled."

# Check the operating system and update initramfs
if [[ -f /etc/debian_version ]]; then
    echo "Detected Debian-based system. Updating initramfs..."
    update-initramfs -u
elif [[ -f /etc/arch-release ]]; then
    echo "Detected Arch Linux. Updating initramfs..."
    mkinitcpio -P
elif [[ -f /etc/fedora-release ]]; then
    echo "Detected Fedora-based system. Updating initramfs..."
    dracut --force
else
    echo "Unknown or unsupported operating system. Please update initramfs manually."
    exit 1
fi

echo "Initramfs has been updated. Please reboot your system for changes to take effect."
