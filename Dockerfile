# Stage 1: Build dependencies
FROM composer:2.7 AS builder

WORKDIR /app

# Copy only dependency files to leverage caching
COPY composer.json composer.lock ./

# Install dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Stage 2: Runtime image
FROM php:8.1-fpm-alpine

WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    libpng-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql gd zip \
    && apk del libpng-dev libzip-dev \
    && rm -rf /var/cache/apk/*

# Copy application code
COPY . .

# Copy dependencies from builder stage
COPY --from=builder /app/vendor ./vendor

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copy .env.example as .env (will be overridden by runtime env vars)
COPY .env.example .env

# Generate application key
RUN php artisan key:generate --quiet

# Expose port
EXPOSE 8000

# Start Laravel server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]