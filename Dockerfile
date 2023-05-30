FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get update  \
    && apt-get install software-properties-common ca-certificates lsb-release apt-transport-https  -y
RUN add-apt-repository -y ppa:ondrej/php \
    && apt-get update

RUN apt-get -y --no-install-recommends install \
    supervisor \
    wget \
    curl \
    git \
    zip \
    unzip \
    pwgen \
    apache2 \
    php5.6 \
    libapache2-mod-php5.6 \
    php5.6-mysql \
    php5.6-mcrypt \
    php5.6-gd \
    php5.6-xml \
    php5.6-mbstring \
    php5.6-gettext \
    php5.6-zip \
    php5.6-curl && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Point CLI to use PHP 5.6
RUN ln -sfn /usr/bin/php5.6 /etc/alternatives/php
RUN rm -rf /var/www/html/*
COPY index.php /var/www/html/index.php

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]