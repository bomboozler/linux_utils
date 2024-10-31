#!/bin/bash

# Update the mirror list using Reflector
sudo reflector --latest 10 --sort rate --protocol https --save /etc/pacman.d/mirrorlist

# Update package database
sudo pacman -Syy

# Add alias to .bashrc if it doesn't already exist
if ! grep -q "alias update-mirror=" ~/.bashrc; then
    echo "alias update-mirror='sudo reflector --latest 10 --sort rate --protocol https --save /etc/pacman.d/mirrorlist && sudo pacman -Syy'" >> ~/.bashrc
    echo "Alias 'update-mirror' added to .bashrc."
else
    echo "Alias 'update-mirror' already exists in .bashrc."
fi

# Reload .bashrc
source ~/.bashrc

echo "Mirror list updated successfully using Reflector!"

