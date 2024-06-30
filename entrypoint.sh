#!/bin/bash
# entrypoint.sh

# Wait for PostgreSQL to start
echo "Waiting for PostgreSQL to start..."
while ! nc -z db 5432; do
  sleep 0.1
done
echo "PostgreSQL started"

# Run any other initialization commands (e.g., database migrations if needed)
python gutendex.py migrate

# Start the Django application
python gutendex.py runserver 0.0.0.0:8000
