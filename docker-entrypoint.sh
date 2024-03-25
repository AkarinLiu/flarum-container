if [ -f /var/www/html/site.php ]; then
    echo "Starting Flarum..."
    apache2ctl -D FOREGROUND
    else
    echo "Installing Flarum..."
    composer create-project flarum/flarum /var/www/html
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    echo "Starting Flarum..."
    apache2ctl -D FOREGROUND
fi