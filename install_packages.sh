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
# asks user if he is sure he want to proceed and install packages and suggest he might want to exclude some packages using the option -e with the script
read -p "Do you want to proceed and install packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
# Install AUR packages
    echo "Installing AUR packages..."
    install_packages "${AUR_PACKAGES[@]}"

# Install pacman packages
    echo "Installing pacman packages..."
    install_packages "${PACMAN_PACKAGES[@]}"
    echo "Installation complete!"
fi

#asks user if he wats to add cachyos kernel and repos
read -p "Do you want to add CachyOS kernel and optimized repos (say no if you want just cachyos kernel)? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Adding CachyOS kernel and repos..."
    curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
    tar xvf cachyos-repo.tar.xz && cd cachyos-repo
    sudo ./cachyos-repo.sh
    sudo pacman -S --noconfirm linux-cachyos
    echo "Optimized repos and cachyos kernel added successfully!"
fi
#asks user if he wants just the cachyos kernel and installs it

read -p "Do you want just the CachyOS kernel? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
     paru -S --noconfirm linux-cachyos
fi
