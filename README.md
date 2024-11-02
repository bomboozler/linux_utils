# Linux Utils

![Arch Linux Logo](https://archlinux.org/favicon.ico)

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Overview

collection automation scripts I use for my Arch install feel free to use.

## Nvidia_wayland_prep.sh

fixes wayland display issues on nvidia will work with any distro as long as it is using modprob

## Install_packages.sh

**install the following packages:**

paru arch-gaming-meta arch-gaming-meta heroic-games-launcher-bin jellyfin-media-player localsend-bin payload-dumper-go-bin protonup-qt ventoy-bin fish htop fzf ripgrep fastfetch repo git reflector

**installs cachysos kernel and optimized repos**

this part only written for arch based system if you're on debian based or rhel based say no to those prompts.
script will prompt you if you want to install the kernel with optimized repos or as standalone AUR package.
feel free to say no to both if you want to stick to what you have.

**excluding packges from  install_packages.sh**

   ```bash
   ./install_packages.sh -e "package2,package2"
   ```

**update_repo.sh**

update pacman repos and make .bashrc alias for easier updating in the future using update-mirror command.

