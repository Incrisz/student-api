.PHONY: install build run test migrate docker-build docker-run docker-push \
        db-start db-migrate api-build api-run setup-tools check-db check-migrations

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
	docker build -t ghcr.io/incrisz/student-api:1.0.0 .

docker-run:
	docker run --rm -p 8000:8000 --env-file .env ghcr.io/incrisz/student-api:1.0.0

docker-push:
	docker push ghcr.io/incrisz/student-api:1.0.0

# Docker Compose targets
db-start:
	docker-compose up -d db

db-migrate:
	@docker-compose exec -T api php artisan migrate || echo "Migrations failed. Ensure DB is running."

api-build:
	docker-compose build api

api-run: db-start check-db db-migrate
	docker-compose up -d api

# Tool installation
setup-tools:
	@echo "Installing Docker and Make..."
	@./scripts/setup-tools.sh

# Health checks
check-db:
	@until docker-compose exec -T db mysqladmin ping -h localhost --silent; do \
		echo "Waiting for database to be ready..."; \
		sleep 2; \
	done
	@echo "Database is ready."

check-migrations:
	@docker-compose exec -T api php artisan migrate:status > /dev/null 2>&1 || \
		(echo "Running migrations..." && docker-compose exec -T api php artisan migrate)