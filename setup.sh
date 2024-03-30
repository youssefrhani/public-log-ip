#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit
fi

chmod +x logip.sh
cp logip.sh /usr/local/bin/
echo "Installation complete"
