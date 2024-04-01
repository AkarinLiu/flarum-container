FROM debian
LABEL org.opencontainers.image.source=https://github.com/AkarinLiu/flarum-container
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php-common php-mysql php-mbstring php-xml php-curl php-exif php-gd php-intl php-soap php-zip composer
RUN phpenmod fileinfo exif pdo_mysql mbstring xml curl gd intl soap zip
RUN a2enmod rewrite
COPY php.ini /etc/php/8.2/apache2/php.ini
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN composer create-project flarum/flarum /flarum
COPY config.php /config.php
ENV FLARUM_DB_HOST=mysql
ENV FLARUM_DB_DATABASE=flarum
ENV FLARUM_DB_USERNAME=root
ENV FLARUM_DB_PASSWORD=root
ENV FLARUM_DB_PREFIX=flarum_
EXPOSE 80
ENTRYPOINT bash /docker-entrypoint.sh