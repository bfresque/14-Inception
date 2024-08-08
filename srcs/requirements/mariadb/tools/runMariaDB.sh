#!/bin/bash

# Démarrer le service MariaDB
service mariadb start

# Attendre que MariaDB soit prêt à accepter des connexions
until mysqladmin ping -h "localhost" --silent; do
  echo "Waiting for MariaDB to be ready..."
  sleep 1
done

# Exécuter les commandes SQL
mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');
FLUSH PRIVILEGES;
EOF

# Exécuter la commande passée en argument (par exemple, mysqld_safe)
exec "$@"