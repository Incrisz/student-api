.PHONY: install build run test migrate

install:
	composer install

build:
	@echo "No build step required for Laravel"

run:
	php artisan serve

test:
	php artisan test

migrate:
	php artisan migrate