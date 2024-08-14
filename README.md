# Inception

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Makefile Commands](#makefile-commands)
- [Docker Configuration](#docker-configuration)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Overview

Inception is a Docker-based project that sets up a complete web stack consisting of a MariaDB database, a WordPress site, and an Nginx server. The project demonstrates how to use Docker and Docker Compose to orchestrate multiple services while following best practices for containerization and security.

## Features

- **MariaDB**: A relational database to store WordPress data.
- **WordPress**: A content management system that serves as the main website.
- **Nginx**: A web server that serves static content and acts as a reverse proxy for PHP-FPM.
- **PHP-FPM**: Handles PHP processing for WordPress.
- **SSL Support**: Nginx is configured to serve the WordPress site over HTTPS.

## Project Structure

```bash
Inception/
├── Makefile
├── srcs/
│   ├── docker-compose.yml
│   ├── requirements/
│   │   ├── mariadb/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   │       └── my.cnf
│   │   ├── wordpress/
│   │   │   ├── Dockerfile
│   │   │   ├── setup_wordpress.sh
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   ├── conf/
│   │   │   │   └── nginx.conf
│   ├── tools/
│   │   └── init_dir.sh
│   └── .env
└── README.md
```

## Requirements

- Docker
- Docker Compose
- Git
- Make

## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/Inception.git
    cd Inception
    ```

2. **Set up the environment**:
   - Ensure that the `.env` file contains your environment variables for MariaDB, WordPress, and SSL certificates.
   - If you are on macOS, ensure that the `init_dir.sh` script is configured to handle your file paths properly.

3. **Run the setup**:
   ```bash
   make
   ```

## Usage

1. **Access the WordPress site**:
   - Open your browser and navigate to `https://your-domain.com`.
   - You should see the WordPress installation screen.

2. **Stopping the services**:
   ```bash
   make down
   ```

3. **Rebuilding and restarting services**:
   ```bash
   make re
   ```

## Makefile Commands

- `make`: Builds and starts the entire application.
- `make build`: Rebuilds the Docker images and starts the services.
- `make down`: Stops all running containers and removes volumes.
- `make re`: Rebuilds and restarts the application.
- `make clean`: Stops all containers and removes Docker images.
- `make fclean`: Removes all containers, images, networks, and volumes, and deletes the data directories.

## Docker Configuration

### Docker Compose

The `docker-compose.yml` file orchestrates the following services:

- **mariadb**: A MariaDB database with persistent storage.
- **wordpress**: A WordPress installation using PHP-FPM.
- **nginx**: A web server configured with SSL and reverse proxy to PHP-FPM.

### Dockerfiles

Each service has its own Dockerfile under the `requirements` directory. These Dockerfiles define the base image, required packages, configuration files, and startup commands.

### Environment Variables

Environment variables are stored in the `.env` file and are used to configure MariaDB, WordPress, and Nginx.

## Troubleshooting

- **Permission Issues**: Ensure that directory permissions are correctly set for Docker volumes.
- **Docker Build Errors**: Check if your Docker daemon is running and if all required packages are installed.
- **SSL Configuration**: Ensure your SSL certificates are correctly set up in the `.env` file and referenced in the Nginx configuration.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.