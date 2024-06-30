#!/bin/bash
# Start PostgreSQL service
service postgresql start
# Keep the container running
tail -f /dev/null
