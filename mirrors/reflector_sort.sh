#!/bin/bash

read -p "Do you want to sort servers by country? Otherwise all available mirrors will be searched. (Y/N)" country_choice

if [[ $country_choice =~ ^[sSyY] ]]; then
    read -p "Enter the country codes separated by commas (e.g. US,DE,JP):" countries
    echo "Testing on the specified mirrors. This may take a few minutes..."
    reflector --country "$countries" --sort rate --save /tmp/mirrorlist_temp.txt
else
    echo "Testing on all available mirrors. This may take several minutes..."
    reflector --sort rate --save /tmp/mirrorlist_temp.txt
fi

  # ... (Código para filtrar servidores y realizar pruebas de ping)
