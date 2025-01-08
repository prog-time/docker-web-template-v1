#!/bin/bash

# ПЕРЕНОС ФАЙЛОВ ПРОЕКТА
# ----------------------------
# Копируем файлы из директории files в www/public
SOURCE_FILE="files"
DESTINATION="www/public"

cp "$SOURCE_FILE"/* "$DESTINATION"
# END ----------------------------

# Переход в директорию www/public
cd www/public || exit
# END ----------------------------

# Установка зависимостей в composer.json
if [ -e .php-cs-fixer.php ]; then
    composer require --dev friendsofphp/php-cs-fixer
fi

if [ -e phpstan.neon ]; then
    composer require --dev phpstan/phpstan
fi

composer require --dev phpunit/phpunit
# END ----------------------------

# ИНИЦИАЛИЗАЦИЯ ПАКЕТОВ
# ----------------------------
# Выполнение composer update
composer update

# Инициализация git-репозитория
if [ ! -d .git ]; then
    git init
fi

# Возвращаемся в корневую директорию
cd ../../ || exit

# Добавляем тесты для проекта
cp -r ./docker/git/* ./www/public/.git/hooks/

# Добавляем тесты и рефакторинг для Docker сборки
if [ ! -d .git ]; then
    cp ./docker/git_docker/* ./.git/hooks/
fi
