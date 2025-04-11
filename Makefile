.PHONY: install build run test migrate docker-build docker-run docker-push

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

# Docker targets
docker-build:
	docker build -t ghcr.io/<your-username>/student-api:1.0.0 .

docker-run:
	docker run --rm -p 8000:8000 --env-file .env ghcr.io/<your-username>/student-api:1.0.0

docker-push:
	docker push ghcr.io/<your-username>/student-api:1.0.0