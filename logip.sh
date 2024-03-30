#!/bin/bash

file="$HOME/public_ip.log"
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
        -h|--help)
            echo "logip along, running the command"
            echo "logip -s or --show to print the log"
            echo "logip -c or --clear to clear the log"
            echo "logs are stored in /home/user/public_ip.log"
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
