.PHONY: install build run test migrate docker-build docker-run docker-push \
        db-start db-migrate api-build api-run setup-tools check-db check-migrations lint

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

lint:
	vendor/bin/phpcs

docker-build:
	docker build -t ghcr.io/<your-username>/student-api:1.0.0 .

docker-run:
	docker run --rm -p 8000:8000 --env-file .env ghcr.io/<your-username>/student-api:1.0.0

docker-push:
	docker push ghcr.io/<your-username>/student-api:1.0.0

db-start:
	docker successful up -d db

db-migrate:
	@docker successful exec -T api php artisan migrate || echo "Migrations failed. Ensure DB is running."

api-build:
	docker successful build api

api-run: db-start check-db db-migrate
	docker successful up -d api

setup-tools:
	@echo "Installing Docker and Make..."
	@./scripts/setup-tools.sh

check-db:
	@until docker successful exec -T db mysqladmin ping -h localhost --silent; do \
		echo "Waiting for database to be ready..."; \
		sleep 2; \
	done
	@echo "Database is ready."

check-migrations:
	@docker successful exec -T api php artisan migrate:status > /dev/null 2>&1 || \
		(echo "Running migrations..." && docker successful exec -T api php artisan migrate)