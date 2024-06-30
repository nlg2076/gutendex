#!/bin/bash
# Start PostgreSQL service
service postgresql start
# Apply database migrations
python gutendex.py migrate
# Start the Django development server
python gutendex.py runserver 0.0.0.0:8000
