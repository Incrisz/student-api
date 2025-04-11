# Student API


### 🔧 Installation

```bash
# Clone the repository
git clone https://github.com/incrisz/student-api.git
cd student-api

# Install dependencies
make install

# Copy environment config
cp .env.example .env

# Create SQLite database file
touch database/database.sqlite

# Run migrations
make migrate

# Start the application
make run

# Run automated tests
make test


### Docker Installation

# Build the Docker image:
make docker-build

# Run the Docker container:
make docker-run

# Alternatively, run with custom environment variables:
docker run --rm -p 8000:8000 --env-file .env ghcr.io/incrisz/student-api:1.0.0

# Access the API at http://localhost:8000.

# Pushing to Registry
# Push the image to GitHub Container Registry:

make docker-push

# Ensure you’re logged in to ghcr.io:
docker login ghcr.io -u <your-username>

# Run unit tests:
make test