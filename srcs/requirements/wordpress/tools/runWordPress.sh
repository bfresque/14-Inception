#!/bin/bash

# Fonction pour vérifier si MariaDB est prêt
function check_mariadb() {
  mysql -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e "SHOW DATABASES;" > /dev/null 2>&1
}

# Attendre que MariaDB soit prêt
echo "Checking MariaDB availability..."
while ! check_mariadb; do
    echo "Waiting for MariaDB to be ready..."
    sleep 5
done

echo "MariaDB is ready!"

# Changer de répertoire pour le répertoire d'installation de WordPress
cd /var/www/html

# Vérifier si le fichier wp-config.php existe pour déterminer si WordPress est installé
if [ -f wp-config.php ]; then
    echo "WordPress is already installed."
else
    # Télécharger et extraire WordPress
    echo "Downloading WordPress..."
    wp core download --allow-root
    
    # Configurer WordPress
    echo "Creating wp-config.php file..."
    wp config create --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --dbhost="${WORDPRESS_DB_HOST}" --allow-root

    # Installer WordPress
    echo "Installing WordPress..."
    wp core install --url="${DOMAIN_NAME}" --title="Your Blog Title" --admin_user="${WORDPRESS_ADMIN_USER}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}" --allow-root
fi

# Démarrer PHP-FPM
echo "Starting PHP-FPM..."
php-fpm7.4 -F