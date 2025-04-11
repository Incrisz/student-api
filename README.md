# Student API

A REST API for managing student records, built with Laravel. Supports CRUD operations with API versioning.

## Setup Instructions

### Prerequisites
- PHP >= 8.2
- Composer
- SQLite (or another database like MySQL)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/student-app.git
   cd student-app

   make install

   cp .env.example .env

   touch database/database.sqlite

   make migrate

   make run

   make test



---

### Step 8: Best Practices and Twelve-Factor App

1. **REST API Best Practices**:
   - Use proper HTTP verbs (`GET`, `POST`, `PUT`, `DELETE`).
   - Return appropriate status codes (e.g., `201` for creation, `404` for not found).
   - Version APIs (`/api/v1/`).
   - Validate input data.
   - Use JSON for request/response bodies.
   - Implement logging for debugging and monitoring.

2. **Twelve-Factor App**:
   - **Codebase**: One repo on GitHub.
   - **Dependencies**: Explicitly declared in `composer.json`.
   - **Config**: Stored in `.env`.
   - **Backing Services**: Database is treated as an attachable resource.
   - **Build, Release, Run**: `Makefile` separates build (`composer install`) and run (`php artisan serve`).
   - **Processes**: API is stateless.
   - **Port Binding**: Laravel exposes the app via HTTP.
   - **Logs**: Configured to output to `storage/logs`.

---

### Step 9: Finalize and Push

1. **Add Files to Git**:
   ```bash
   git add .
   git commit -m "Implement student CRUD API with Laravel"
   git push origin main