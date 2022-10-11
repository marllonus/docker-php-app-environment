FROM php:8.1-fpm

ARG USER_ID
ARG GROUP_ID
ARG NODE_VERSION=18.x

COPY ./php-conf.d/php.ini-development "$PHP_INI_DIR"
COPY ./php-conf.d/php.ini-production "$PHP_INI_DIR"
COPY --from=composer:2.3.10 /usr/bin/composer /usr/local/bin/composer

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" && \
	docker-php-ext-install mysqli pdo pdo_mysql && \
	apt-get update && \
        curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - &&\
        apt-get install -y nodejs &&\
	apt-get install -y libzip-dev zip unzip && \
	docker-php-ext-install zip

RUN addgroup --gid $USER_ID user && \
	adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
USER user
WORKDIR /var/www/

EXPOSE 9000
