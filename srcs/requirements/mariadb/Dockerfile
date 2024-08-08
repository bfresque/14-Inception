FROM debian:bullseye

# Mettre à jour les paquets et installer MariaDB
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests apt-utils mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copie le fichier de configuration personnalisé de MariaDB dans le conteneur
COPY conf/mysql.conf /etc/mysql/my.cnf

# Copie le script de démarrage personnalisé de MariaDB dans le conteneur
COPY ./tools/runMariaDB.sh /runMariaDB.sh

# Change les permissions du script de démarrage pour le rendre exécutable
RUN chmod +x /runMariaDB.sh

# Expose le port 3306 pour les connexions MariaDB
EXPOSE 3306

# Définit la commande par défaut pour démarrer MariaDB avec le script de démarrage personnalisé
CMD ["/runMariaDB.sh", "mysqld"]
