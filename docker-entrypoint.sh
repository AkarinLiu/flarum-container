#!/bin/bash
if [ ! -f /var/www/html/site.php ]; then
    echo "Detect Installed, Skipping..."
    exit 0
else
    echo "Detect Not Installed, Installing..."
    cp -R /flarum/* /var/www/html/
    composer install 
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
fi
