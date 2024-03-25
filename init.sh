#!/bin/bash
composer create-project flarum/flarum /var/www/html 
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html