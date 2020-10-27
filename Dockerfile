FROM php:7.3.23-fpm
MAINTAINER Mischa Braam "mischa@weprovide.com"

RUN apt-get -yq update
RUN apt-get -yq upgrade

# Install dependencies
RUN apt-get install -y \
    unzip \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt-dev \
    libxml2-dev \
    git-core \
    libzip-dev \
    curl \
    build-essential \
    sendmail-bin \
    sendmail \
    sudo \
    software-properties-common \
    libsodium-dev \
    rsync \
    gpg \
    apt-transport-https ca-certificates

# Configure the gd library
RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

# Install required PHP extensions
RUN docker-php-ext-install \
  dom \
  gd \
  intl \
  mbstring \
  pdo pdo_mysql \
  xsl \
  zip \
  soap \
  sockets \
  sodium \
  bcmath

RUN pecl install -f libsodium

# Install composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --version=1.10.16
RUN mv composer.phar /usr/local/bin/composer
