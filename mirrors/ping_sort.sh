#!/bin/bash
ping_tmp="$TMP_DIR/ping_result"
: > "$ping_tmp"
count=0
grep -m 20 '^Server' ${reflector_tmp} | while read -r line; do
    server_domain=$(echo "$line" | awk -F'[/]' '{print $3}')
    echo "Performing ping test for $server_domain..."
    ping_result=$(ping -c 5 -W 2 $server_domain 2>/dev/null | awk -F'/|=' '/^rtt/ {print $6}')

    if [[ ! -z "$ping_result" ]]; then
        echo "$server_domain has a median ping time of ${ping_result} ms."
        echo "$line - $ping_result" >> "$ping_tmp"
        ((count++))
    else
        echo "Could not obtain ping time for $server_domain."
    fi
done
