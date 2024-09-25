# Use PHP 8.3.9 as the base image
FROM php:8.3.9-apache

# Set the working directory
WORKDIR /var/www/html

# Enable Apache Mod Rewrite
RUN a2enmod rewrite

# Install required Linux libraries
RUN apt-get update -y && apt-get install -y \
    libicu-dev \
    libmariadb-dev \
    unzip zip \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY ./laravel-app/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Install required PHP extensions
RUN docker-php-ext-install gettext intl pdo_mysql gd

# Configure GD with Freetype and JPEG support, then install GD
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd