#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit
fi

if cp your_script.sh /usr/local/bin/; then
    echo "Installation complete"
else
    echo "Error"
fi
