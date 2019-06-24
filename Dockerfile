FROM espereverde/owncloud-ubuntu:latest

EXPOSE 8080

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/server"]

RUN [ "cross-build-start" ]

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y \
    apache2 \
    libapache2-mod-php \
    php-gd \
    php-json \
    php-mysql \
    php-sqlite3 \
    php-pgsql \
    php-curl \
    php-intl \
    php-imagick \
    php-zip \
    php-xml \
    php-mbstring \
    php-soap \
    php-ldap \
    php-apcu \
    php-redis \
    php-smbclient \
    smbclient \
    patch \
    mysql-client \
    postgresql-client \
    sqlite && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /etc/apache2/envvars /etc/apache2/conf-* /etc/apache2/sites-* /var/log/apache2/* && \
  a2enmod rewrite headers env dir mime expires remoteip && \
  mkdir -p /var/www/html && \
  chown -R www-data:www-data /var/www/html /var/log/apache2 /var/run/apache2 && \
  chsh -s /bin/bash www-data
  
RUN [ "cross-build-end" ]

COPY rootfs /
WORKDIR /var/www/html
