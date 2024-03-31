FROM alpine
LABEL org.opencontainers.image.source=https://github.com/AkarinLiu/flarum-container
WORKDIR /var/www/html
RUN apk update && apk add apache2 php-apache2 php-common php-mbstring php-pdo_mysql php-fileinfo php-exif php-zip php-openssl php-gd php-soap php-curl php-intl php-opcache php-tokenizer php-json php-dom composer
COPY php.ini /etc/php82/php.ini
COPY httpd.conf /etc/apache2/httpd.conf
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN composer create-project flarum/flarum /flarum
EXPOSE 80
ENTRYPOINT bash /docker-entrypoint.sh