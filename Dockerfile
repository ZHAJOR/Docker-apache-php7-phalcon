FROM debian:jessie

MAINTAINER Pierre-Antoine 'ZHAJOR' Tible <antoinetible@gmail.com>

# The Dotdeb repository for Php 7
RUN apt-get update && apt-get install -y wget git re2c apt-utils apt-transport-https \
    &&  echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list \
    && wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg  && rm dotdeb.gpg\
    && apt-get update \
    && apt-get -y install apache2 \
    php7.0 \
    php7.0-dev \
    libapache2-mod-php7.0 \
    php7.0-common \
    php-pear \
    php7.0-curl \
    php7.0-gd \
    php7.0-imagick \
    php7.0-intl \
    php7.0-mcrypt \
    php7.0-pgsql \
    php7.0-opcache \
    php7.0-mysql \
    php7.0-mongodb \
    php7.0-bz2 \
    && apt-get clean

#Phalcon installation
RUN cd /home \
    && git clone --depth=1 http://github.com/phalcon/cphalcon.git \
    && cd cphalcon/build \
    && ./install \
    && echo 'extension=phalcon.so' > /etc/php/7.0/mods-available/phalcon.ini \
    && echo 'extension=phalcon.so' > /etc/php/7.0/apache2/conf.d/20-phalcon.ini


RUN ln -sf /dev/stdout /var/log/apache2/access.log 
RUN ln -sf /dev/stderr /var/log/apache2/error.log

COPY apache2.conf /etc/apache2/apache2.conf

RUN /usr/sbin/a2enmod rewrite

RUN rm -rf /var/www/html
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www/html
RUN chown -R www-data:www-data /var/lock/apache2 /var/run/apache2 /var/log/apache2 /var/www/html

ADD run.sh /run.sh
RUN chmod -v +x /run.sh

EXPOSE 80

VOLUME ["/var/www/html"]

CMD ["/run.sh"]
