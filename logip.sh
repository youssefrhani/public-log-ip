#!/bin/bash

file="/var/local/public_ip.log"
date=$(date +'%d/%m/%y %H:%M')
ssid=$(nmcli connection show --active | awk 'NR>1 {print $1}' | head -n 1)

# Check if file exists, if not, create it and add the header
if [ ! -e "$file" ]; then 
    touch "$file"
    echo -e "| IP Address   \t |Date\t\t  |Network  \t|" > $file
    echo -e "|-----------------|-----------------|-----------------|" >> $file
fi

# Process command line options
while [ "$#" -gt 0 ]; do
    case "$1" in
        -c|--clear)
            rm "$file"
            echo "Log file cleared."
            exit 0
            ;;
    -s|--show)
        cat $file
            exit 0
        ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

# Get public IP address
ip=$(curl 'ifconfig.me')

# Write the new log entry in table format
printf "| %-15s | %-15s | %-15s |\n" "$ip" "$date" "$ssid" >> $file
