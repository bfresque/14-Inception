FROM debian:bullseye-slim

# Installer PHP et php-fpm et les extentions necessaires
RUN apt-get update && \
	apt-get install -y php-fpm php-mysql wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Telecharger et installer WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    chown -R www-data::www-data /var/www/html

# Copier les fichiers de configuration
COPY ./conf/wp-config.php /var/www/html/wp-config.php


# Exposer le port 9000
EXPOSE 9000

# Commande pour demarrer php-fpm
CMD [¨php-fpm¨]
