#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit
fi

cp your_script.sh /usr/local/bin/

echo "Installation complete. You can now use 'your_command' directly."
