FROM debian
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php-common php-mysql php-mbstring php-xml php-curl php-exif php-gd php-intl php-soap php-zip composer
RUN phpenmod fileinfo exif pdo_mysql mbstring xml curl gd intl soap zip
RUN a2enmod rewrite
COPY php.ini /etc/php/8.2/apache2/php.ini
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN rm -rf /var/www/html/*
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
RUN composer create-project flarum/flarum /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
VOLUME [ "/var/www/html" ]
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
