# 🎓 Student API

A RESTful API for managing student records, built with **Laravel**. Supports full **CRUD** operations and includes **API versioning**.

---

## 🚀 Features

- CRUD operations on student records  
- API versioning (`v1`)  
- Input validation  
- Health check endpoint  
- Follows REST best practices  
- Uses SQLite (or optionally MySQL)

---

## 📦 Setup Instructions

### ✅ Prerequisites

- PHP >= 8.2  
- Composer  
- SQLite (or another DB like MySQL)  
- Make (for convenience)

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


<!-- Security scan triggered at 2026-08-31 18:24:47 -->