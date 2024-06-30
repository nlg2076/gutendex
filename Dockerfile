# Use an official Python runtime as a parent image
FROM python:3.6

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Add PostgreSQL APT repository and install PostgreSQL 9.6 and Netcat
RUN apt-get update && \
    apt-get install -y wget gnupg netcat && \
    wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    . /etc/os-release && echo "deb http://apt.postgresql.org/pub/repos/apt/ ${VERSION_CODENAME}-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y postgresql-9.6 postgresql-contrib-9.6

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entrypoint script into the container
COPY entrypoint.sh /usr/src/app/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/src/app/entrypoint.sh

# Expose the default PostgreSQL port
EXPOSE 5432

# Expose the Django development server port
EXPOSE 8000

# Use the entrypoint script to start PostgreSQL and keep the container running
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
