#!/bin/bash

# Wait for MySQL to be ready
sleep 10

# Create database
mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS laravel;"

# Install Laravel if not present
if [ ! -f artisan ]; then
  composer create-project laravel/laravel .
fi

cp .env.example .env

php artisan key:generate

# Configure MySQL
sed -i 's/DB_CONNECTION=.*/DB_CONNECTION=mysql/' .env
sed -i 's/DB_HOST=.*/DB_HOST=127.0.0.1/' .env
sed -i 's/DB_PORT=.*/DB_PORT=3306/' .env
sed -i 's/DB_DATABASE=.*/DB_DATABASE=laravel/' .env
sed -i 's/DB_USERNAME=.*/DB_USERNAME=root/' .env
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=root/' .env

# Run migrations
php artisan migrate

# Frontend
npm install
npm run build
