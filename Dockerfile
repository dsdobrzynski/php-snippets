FROM php:8.2.4-apache-bullseye

ARG ARCH

ARG DEBIAN_FRONTEND=noninteractive
COPY config/bash/profile /root/.bashrc
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
# libpng-dev needed for php ext-gd
RUN apt-get install -y \
        python \
        libxml2-dev \
        dialog \
        git \
        zip \
        unzip \
        apt-utils \
        libnotify-bin \
        build-essential \
        patch \
        iproute2 \
        acl \
        zlib1g-dev \
        libzip-dev \
        libpq-dev \
        curl \
        libmagickwand-dev \
        libicu-dev \
        libpng-dev \
        chromium \
        # libzstd-dev needed for pecl redis
        libzstd-dev
RUN a2enmod \
        rewrite \
        ssl \
        headers \
        actions
RUN pecl config-set php_ini /usr/local/etc/php/php.ini \
    && pecl install \
        redis \
        acpu \
        mongodb \
        imagick \
    && echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini \
    && echo "extension=redis.so" >> /usr/local/etc/php/conf.d/redis.ini
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
# kartik-v/yii2-export requires phpoffice/phpspreadsheet which requires gd extension
RUN docker-php-ext-install \
        soap \
        bcmath \
        zip \
        opcache \
        pdo \
        pdo_pgsql \
        pcntl \
        gd \
        sockets
RUN docker-php-ext-enable imagick
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN chmod -R 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get install -y nodejs

# need bower for leadworks/js/angularjs directory
RUN npm install -g bower

COPY config/scripts/install-composer.sh /usr/local/bin/install-composer.sh
RUN install-composer.sh

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN ln -sfT /dev/stderr "$APACHE_LOG_DIR/error.log"
COPY config/php/php.ini /usr/local/etc/php

WORKDIR /var/www/html

ARG WITH_XDEBUG=false
COPY config/php/xdebug.ini /tmp/xdebug.ini
RUN if [ $WITH_XDEBUG = "true" ] ; then \
    apt-get install -y nano vim; \
    pecl config-set php_ini /usr/local/etc/php/php.ini; \
    pecl install xdebug; \
    docker-php-ext-enable xdebug --ini-name docker-php-ext-xdebug.ini; \
    cat /tmp/xdebug.ini >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    fi;

COPY config/apache2/default-ssl/000-default.conf /etc/apache2/sites-available
COPY config/apache2/conf/apache2.conf /etc/apache2/conf-enabled/apache2.conf

COPY config/scripts/startup.sh /startup.sh

COPY src /var/www/html

ARG ENV=dev

EXPOSE 80

CMD apache2-foreground
