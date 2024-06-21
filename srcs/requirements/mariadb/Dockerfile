FROM mariadb:latest

# Definir les variables d´environement de MariaDB
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=wordpress
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Exposer le port 3306
EXPOSE 3306

# Commande pour demarrer MariaDB
CMD [¨mysqld¨]
