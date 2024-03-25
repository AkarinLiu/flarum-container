FROM debian
LABEL org.opencontainers.image.source=https://github.com/AkarinLiu/flarum-container
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php-common php-mysql php-mbstring php-xml php-curl php-exif php-gd php-intl php-soap php-zip composer
RUN phpenmod fileinfo exif pdo_mysql mbstring xml curl gd intl soap zip
RUN a2enmod rewrite
COPY php.ini /etc/php/8.2/apache2/php.ini
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
RUN composer create-project flarum/flarum /flarum
RUN chown -R www-data:www-data /flarum
RUN chmod -R 755 /flarum
ENTRYPOINT if [ -f /var/www/html/site.php ]; then \
    echo 'skipping...'; \
else \
    echo 'Copying Flarum...'; \
    cp -r /flarum/* /var/www/html/; \
    chown -R $(id -u www-data):$(id -g www-data) /var/www/html/; \
    chmod -R 755 /var/www/html/; \
    echo 'Flarum installed.'; \
fi

VOLUME [ "/var/www/html" ]
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
