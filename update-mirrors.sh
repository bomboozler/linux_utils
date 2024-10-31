#!/bin/bash

# Update the mirror list using Reflector
sudo reflector --latest 10 --sort rate --protocol https --save /etc/pacman.d/mirrorlist

# Update package database
sudo pacman -Syy

echo "Mirror list updated successfully using Reflector!"

