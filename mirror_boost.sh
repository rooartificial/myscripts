#!/bin/bash

echo "Fetching servers with the highest bandwidth using Reflector..."
reflector --verbose --protocol https --sort rate --save /tmp/mirrorlist_temp.txt

echo "Performing ping tests on the top 20 servers with the highest bandwidth..."

grep -m 20 '^Server' /tmp/mirrorlist_temp.txt > /tmp/server_list.txt

count=0
while read -r line; do
    server_domain=$(echo "$line" | awk -F'[/]' '{print $3}')
    echo "Performing ping test for $server_domain..."
    ping_result=$(ping -c 1 -W 1 $server_domain 2>/dev/null | awk -F'[=]' '/time/ {print $4}' | awk '{print $1}')

    if [[ ! -z "$ping_result" ]]; then
        echo "$server_domain has a ping time of ${ping_result} ms."
        echo "$line - $ping_result" >> /tmp/mirrorlist_low_ping.txt
        ((count++))
    else
        echo "Could not obtain ping time for $server_domain."
    fi
done < /tmp/server_list.txt

if [ $count -eq 0 ]; then
    echo "Could not obtain ping time for any server."
    exit 1
fi

sort -k4 -n /tmp/mirrorlist_low_ping.txt | head -n 10 | awk -F'[-]' '{print $1}' > /tmp/mirrorlist_low_ping_sorted.txt

read -p "Do you want to update the mirror list in /etc/pacman.d/mirrorlist with the lowest ping servers? [Y/n]: " choice

case "$choice" in
  n|N|no|NO)
    echo "Mirror list has not been updated."
    ;;
  *)
    sudo cp /tmp/mirrorlist_low_ping_sorted.txt /etc/pacman.d/mirrorlist
    echo "Mirror list has been updated."
    ;;
esac

# Delete temporary files
[ -f /tmp/mirrorlist_temp.txt ] && rm /tmp/mirrorlist_temp.txt
[ -f /tmp/server_list.txt ] && rm /tmp/server_list.txt
[ -f /tmp/mirrorlist_low_ping.txt ] && rm /tmp/mirrorlist_low_ping.txt
[ -f /tmp/mirrorlist_low_ping_sorted.txt ] && rm /tmp/mirrorlist_low_ping_sorted.txt

