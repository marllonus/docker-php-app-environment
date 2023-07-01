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
        pecl install -o -f redis && \
        rm -rf /tmp/pear && \
        docker-php-ext-enable redis && \
        curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - &&\
        apt-get install -y nodejs &&\
        npm add -D sass &&\
	apt-get install -y libzip-dev zip unzip && \
	docker-php-ext-install zip && \
        mkdir /web-drivers && \
        curl -fsSL github.com/mozilla/geckodriver/releases/download/v0.32.2/geckodriver-v0.32.2-linux64.tar.gz -o /web-drivers/mozgeckodriver.tar.gz && \
        tar -zxf /web-drivers/mozgeckodriver.tar.gz -C /usr/local/bin/ && \
        chmod +x /usr/local/bin/geckodriver && \
        #mv /web-drivers/geckodriver /usr/local/bin/ && \
        #apt install -y glibc-source libgtk-3-dev libstdc++6 && \
        apt install -y wget bzip2 libxtst6 libgtk-3-0 libx11-xcb-dev libdbus-glib-1-2 libxt6 libpci-dev libasound2 libgl1-mesa-glx && \
        rm -rf /var/lib/apt/lists/* && \
        curl -fsSL https://ftp.mozilla.org/pub/firefox/releases/111.0/linux-x86_64/en-GB/firefox-111.0.tar.bz2 -o /web-drivers/firefox-111.0.tar.bz2 && \
        tar -xjf /web-drivers/firefox-111.0.tar.bz2 -C /opt/ && \
        #mv /web-drivers/firefox /usr/lib && \
        #ln -s /usr/lib/firefox /usr/bin/firefox && \
        #mkdir /usr/lib/firefox && \
        ln -s /opt/firefox/firefox /usr/local/bin/firefox

RUN addgroup --gid $USER_ID user && \
	adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user && \
        echo 'WEBDRIVER_FIREFOX_DRIVER=/usr/local/bin/geckodriver' >> /home/user/.bashrc
        #echo 'PATH=$PATH:/usr/local/bin' >> /home/user/.bashrc

#USER user
WORKDIR /var/www/



EXPOSE 9000
