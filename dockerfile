FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    libzip-dev \
    unzip \
    nodejs \
    npm \
    vim

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd xml zip



COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www/html

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html


RUN composer install --ignore-platform-reqs

RUN npm install


