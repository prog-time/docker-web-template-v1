FROM php:8.3-fpm

# Установка пользователя root по умолчанию
USER root

## НАСТРОЙКА СЕРВЕРА И УСТАНОВКА МОДУЛЕЙ
## ----------------------------
RUN apt-get update && apt-get install -y \
    git \
    nodejs npm \
    curl \
    zip \
    unzip \
    libpq-dev && \
    docker-php-ext-install pdo pdo_pgsql pgsql

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . .

# Копируем pdo_pgsql.ini в контейнер
COPY ./docker/php/php.ini /usr/local/etc/php/conf.d/

# Установка composer и npm зависимостей
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER=1

## END ----------------------------

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

COPY --chown=www:www . /var/www
USER www
EXPOSE 9000
CMD ["php-fpm"]
