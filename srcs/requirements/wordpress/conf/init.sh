#!/bin/bash
set -e

until mysqladmin ping -h "mariadb" -u "${DB_USER}" -p"${DB_PASS}" --silent; do
  echo "Waiting for MariaDB..."
  sleep 2
done

# Create /var/www/html if volume is empty
if [ ! -d "/var/www/html" ] || [ -z "$(ls -A /var/www/html)" ]; then
    echo "Initializing WordPress in /var/www/html..."
    mkdir -p /var/www/html
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
fi

# Wait for MariaDB (now with mysqladmin available)
until mysqladmin ping -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASS}" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Proceed with WordPress installation
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."
    
    cd /var/www/html
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar

    ./wp-cli.phar core download --allow-root --force

    ./wp-cli.phar config create \
        --dbname=${DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PASS} \
        --dbhost=${DB_HOST} \
        --allow-root

    ./wp-cli.phar core install \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASS} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    # (Rest of your WP configuration...)
fi

exec php-fpm7.4 -F
