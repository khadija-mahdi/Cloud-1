#!/bin/bash

# Update database configuration in wp-config.php
sed -i "s/\(define( 'DB_NAME', \).*$/\1'$MARIA_DATABASE' );/" /var/www/html/wp-config.php
sed -i "s/\(define( 'DB_USER', \).*$/\1'$MARIA_USER' );/" /var/www/html/wp-config.php
sed -i "s/\(define( 'DB_PASSWORD', \).*$/\1'$MARIA_PASSWORD' );/" /var/www/html/wp-config.php
sed -i "s/\(define( 'DB_HOST', \).*$/\1'mariadb:3306' );/" /var/www/html/wp-config.php

# Only install WordPress if not already installed
if ! wp core is-installed --allow-root 2>/dev/null; then
    wp core install --allow-root \
        --url=$WORDPRESS_URL \
        --title="Inception" \
        --admin_user=$WORDPRESS_ADMIN_USER \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL

    wp user create --allow-root \
        $WORDPRESS_USER1_NAME $WORDPRESS_USER1_EMAIL \
        --user_pass=$WORDPRESS_USER1_PASSWORD --role=author
fi

# Always ensure the site URL matches the configured value
wp option update siteurl "$WORDPRESS_URL" --allow-root
wp option update home "$WORDPRESS_URL" --allow-root

exec php-fpm7.4 -F
