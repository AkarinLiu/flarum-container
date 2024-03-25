#!/bin/bash
if [ ! -f /var/www/html/site.php ]; then
    echo "Detect Installed, Skipping..."
    exit 0
else
    echo "Detect Not Installed, Installing..."
    rm -rf /var/www/html/*
    composer create-project flarum/flarum /var/www/html
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
fi
