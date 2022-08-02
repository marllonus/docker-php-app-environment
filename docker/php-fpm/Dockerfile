FROM php:8.1-fpm

COPY ./php-conf.d/php.ini-development "$PHP_INI_DIR"
COPY ./php-conf.d/php.ini-production "$PHP_INI_DIR"
COPY --from=composer:2.3.10 /usr/bin/composer /usr/local/bin/composer

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" && \
	docker-php-ext-install mysqli pdo pdo_mysql && \
	apt-get update && apt-get install -y nodejs npm

EXPOSE 9000
