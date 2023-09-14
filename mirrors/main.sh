#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
TMP_DIR="$SCRIPT_DIR/tmp"
if [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"/*
else
    mkdir -p "$TMP_DIR"
fi
source "$SCRIPT_DIR/dependency.sh"
source "$SCRIPT_DIR/reflector_sort.sh"
source "$SCRIPT_DIR/ping_sort.sh"

echo "$count"
awk -F' - ' '{print $2 " - " $1}' "$ping_tmp" | sort -n -k1,1 | awk -F' - ' '{print $2}' > "$TMP_DIR/ping_sorted"

read -p "Do you want to update the mirror list in /etc/pacman.d/mirrorlist with the lowest ping servers? [Y/n]: " choice

case "$choice" in
  n|N|no|NO)
    echo "Mirror list has not been updated."
    ;;
  *)
    sudo cp "$TMP_DIR/ping_sorted" /etc/pacman.d/mirrorlist
    echo "Mirror list has been updated."
    ;;
esac
