# Cloud-1

Automated Ansible deployment of an Inception-style WordPress stack (nginx, WordPress/php-fpm,
MariaDB, phpMyAdmin) onto a remote Ubuntu 22.04 host, each service in its own container.

## Prerequisites

- Target host: Ubuntu 22.04 (or compatible) with SSH and Python installed, reachable via SSH.
- Control machine: Ansible installed, SSH access to the target as `ubuntu`.

## Setup

1. Create the secrets file (never committed to git):

   ```
   cp srcs/.env.example srcs/.env
   ```

   Then edit `srcs/.env` and set real values for `DOMAIN_NAME` and all passwords.

2. Point `inventory.ini` at your target host:

   ```
   [myhosts]
   your.server.ip ansible_user=ubuntu
   ```

## Deploy

```
make deploy
```

This provisions the system, installs Docker, configures the firewall (only 22/80/443 open),
copies `srcs/` (including your `.env`) to the target, and brings up all containers.

Per-service redeploys are also available: `make deploy-mariadb`, `make deploy-wordpress`,
`make deploy-nginx`, `make deploy-phpmyadmin`.

## Teardown

```
make clean    # stop containers, remove volumes and data
make fclean   # clean + remove images, prune system
```
