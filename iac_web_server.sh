#!/bin/bash

echo "Updating the server..."
apt-get update
apt-get upgrade -y
apt-get install apache2 -y
apt-get install unzip -y

echo "Downloading and copying application files..."
cd /tmp
wget https://github.com/jonasmzsouza/assemble-snack/archive/refs/heads/main.zip
unzip main.zip
cd assemble-snack-main
cp -R * /var/www/html/
