#!/bin/bash
if ! command -v reflector &> /dev/null; then
    read -p "Reflector is not installed. Do you want to install it to continue with the script? [Y/n]: " install_choice
    case "$install_choice" in
      n|N|no|NO)
        exit 1
        ;;
      *)
        sudo pacman -Syu reflector
        ;;
    esac
fi
