# Flarum Container
Flarum 非官方容器镜像，使用 Podman 构建。

## 目标
在Docker或Podman中运行Flarum，并且使用Compose一键安装，易于维护。

## 安装

```yaml
    version: '3'
    services:
        runtime:
            image: ghcr.io/akarinliu/flarum:latest
            restart: always
            volumes:
                - ./data:/var/www/html
            ports:
                - 8080:80
            depends_on:
                - mysql
        mysql:
            image: mariadb:lts
            restart: always
            environment:
                - MYSQL_ROOT_PASSWORD=flarum
                - MYSQL_DATABASE=flarum
                - MYSQL_USER=flarum
                - MYSQL_PASSWORD=flarum
            volumes:
                - ./mysql:/var/lib/mysql
```