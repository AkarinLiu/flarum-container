#!/bin/bash
if [ ! -e "/var/www/html/site.php" ]; then
    echo "Copying Flarum to /var/www/html, please wait..."
    cp -r /flarum/* /var/www/html
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
fi
echo "Starting Flarum..."
httpd -D FOREGROUND