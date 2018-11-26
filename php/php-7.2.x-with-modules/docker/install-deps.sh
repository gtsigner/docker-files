#!/bin/bash

TMP="autoconf \
    curl-dev \
    freetds-dev \
    freetype-dev \
    g++ \
    gcc \
    gettext-dev \
    icu-dev \
    jpeg-dev \
    libmcrypt-dev \
    libpng-dev \
    libwebp-dev \
    libxml2-dev \
    make \
    libsodium-dev \
    openldap-dev \
    postgresql-dev"
apk add $TMP --no-cache

DEPS="coreutils \
		curl-dev \
		libedit-dev \
		libressl-dev \
		libxml2-dev \
		sqlite-dev \
		libmcrypt-dev \
		freetype-dev \
		libpng-dev \
		jpeg-dev \
		gmp-dev \
		cyrus-sasl-dev \
    musl-dev"

apk add $DEPS --no-cache

echo "Extensions Install....." \
    && docker-php-ext-install -j$(nproc) pcntl pdo_mysql mbstring opcache bcmath curl gmp \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --enable-bcmath \
    && docker-php-ext-install -j$(nproc) gd

# 安装Mongodb模块
echo "Install pecl modules ....... " \
  && pecl install igbinary \
  && pecl install mcrypt-1.0.1 \
	&& pecl install redis-${REDIS_VERSION} \
  && pecl install mongodb \
	&& pecl install xdebug-${XDEBUG_VERSION} \
	&& pecl install swoole-${SWOOLE_VERSION}  \
	&& docker-php-ext-enable redis xdebug swoole mongodb mcrypt

# 安装常用工具，phpunit , composer等

# Set timezone
apk add tzdata --no-cache && /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone
