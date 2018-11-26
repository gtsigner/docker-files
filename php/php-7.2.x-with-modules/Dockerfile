FROM php:7.2.12-fpm-alpine3.8

LABEL maintainer="godtoy <zhaojunlike@gmail.com>"

## DESC：容器包含了php-fpm的基础环境,其中支持开启了libevent 支持workman，支持gd，支持pdo_mysql redis等，支持mongodb

ENV XDEBUG_VERSION 2.7.0beta1
ENV REDIS_VERSION 3.1.6
ENV SWOOLE_VERSION 4.2.7

# replace the aliyun mirrors

COPY ./docker/install-deps.sh /install-deps.sh

# 只使用一层layer搞定依赖
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add git bash --no-cache && bash /install-deps.sh

## test phpunit
RUN curl -sSL -o /usr/bin/phpunit https://phar.phpunit.de/phpunit.phar && chmod +x /usr/bin/phpunit

## install composer

#开发模式和健康检查 例：
HEALTHCHECK --interval=1m CMD curl -f http://localhost/ || exit 1
CMD php think run --host=0.0.0.0 --port 80
EXPOSE 80 9000

