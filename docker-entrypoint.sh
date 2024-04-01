#!/bin/bash
if [ ! -e "/var/www/html/site.php" ]; then
    echo "Copying Flarum to /var/www/html, please wait..."
    cp -r /flarum/* /var/www/html
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
fi
if [ ! -e "/var/www/html/config.php" ]; then
    cp -r /config.php /var/www/html/
    sed -i "s/flarum_db_host/${FLARUM_DB_HOST}/g" /var/www/html/config.php
    sed -i "s/flarum_db_name/${FLARUM_DB_NAME}/g" /var/www/html/config.php
    sed -i "s/flarum_db_user/${FLARUM_DB_USER}/g" /var/www/html/config.php
    sed -i "s/flarum_db_password/${FLARUM_DB_PASSWORD}/g" /var/www/html/config.php
    sed -i "s/flarum_db_prefix/${FLARUM_DB_PREFIX}/g" /var/www/html/config.php
    sed -i "s/flarum_url/${FLARUM_URL}/g" /var/www/html/config.php
fi
echo "Starting Flarum..."
httpd -D FOREGROUND