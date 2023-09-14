#!/bin/bash
reflector_tmp="$TMP_DIR/reflector_result"
protocol=$(command -v rsync &> /dev/null && echo "" || echo "--protocol https")
read -p "Do you want to test servers by country? Otherwise all available mirrors will be tested. (Y/N)" country_choice
 
case $country_choice in
    n|N|no|NO)
	echo "Testing on all avaible mirrors. This may take a several minutes..."
	;;
    *)
	read -p "Enter the country codes separated by commas (e.g. US,DE,JP):" countries
	countries="--country $countries"
	echo "Testing on the specified mirrors. This may take a few minutes..."
    ;;
esac

reflector --verbose --age 24 $protocol $countries --sort rate --save $reflector_tmp
