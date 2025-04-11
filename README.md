# Student API

A REST API for managing student records, built with Laravel. Supports CRUD operations with API versioning.

## Setup Instructions

### Prerequisites
- **Required Tools**:
  - Bash (available on Linux/macOS, or WSL on Windows)
- **Optional Tools** (will be installed automatically if missing):
  - Docker
  - Docker Compose
  - GNU Make

### One-Click Local Development Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/incrisz/student-api.git
   cd student-api

# Install required tools (if not already installed):
make setup-tools

# Start the API and database:
make api-run

<!-- Start the API on http://localhost:8000. -->


# Manual Setup (Alternative)
# Install dependencies:
make install

# Start the database:
make db-start

# Run migrations:
make db-migrate

# Build the API image:
make api-build

# Run the API:
make api-run

# Run unit tests:
make test