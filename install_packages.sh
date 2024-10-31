#!/bin/bash

# Function to display a usage message
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -e, --exclude <packages>  Comma-separated list of packages to exclude"
    echo "  -h, --help                 Show this help message"
}

# Default values
EXCLUDE_PACKAGES=""

# Parse command-line arguments
while [[ "$1" != "" ]]; do
    case $1 in
        -e | --exclude )
            shift
            EXCLUDE_PACKAGES="$1"
            ;;
        -h | --help )
            usage
            exit 0
            ;;
        * )
            usage
            exit 1
    esac
    shift
done

# Convert exclude string into an array
IFS=',' read -r -a EXCLUDE_ARRAY <<< "$EXCLUDE_PACKAGES"

# Install paru from source
echo "Installing paru AUR helper..."
git clone https://aur.archlinux.org/paru.git
cd paru || exit
makepkg -si --noconfirm
cd .. || exit
rm -rf paru

# List of AUR packages to install
AUR_PACKAGES=("arch-gaming-meta" "heroic-games-launcher-bin" "jellyfin-media-player" "localsend-bin" "payload-dumper-go-bin" "protonup-qt" "ventoy-bin")

# List of pacman packages to install
PACMAN_PACKAGES=("fish" "htop" "fzf" "ripgrep" "fastfetch" "repo" "git" "reflector")

# Function to install packages while excluding specified ones
install_packages() {
    local package_list=("$@")
    for package in "${package_list[@]}"; do
        if [[ ! " ${EXCLUDE_ARRAY[@]} " =~ " ${package} " ]]; then
            echo "Installing $package..."
            paru -S --noconfirm "$package"
        else
            echo "Skipping $package (excluded)"
        fi
    done
}

# Install AUR packages
echo "Installing AUR packages..."
install_packages "${AUR_PACKAGES[@]}"

# Install pacman packages
echo "Installing pacman packages..."
install_packages "${PACMAN_PACKAGES[@]}"

echo "Installation complete!"

