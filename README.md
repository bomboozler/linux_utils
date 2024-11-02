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

**excluding packges from  install_packages.sh**
   ```bash
   ./install_packages.sh -e "package2,package2"

**update_repo.sh**

update pacman repos and make alias to bash for updating in the future using update-mirror.

