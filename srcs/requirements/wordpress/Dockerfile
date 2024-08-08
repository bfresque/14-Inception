FROM debian:bullseye

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates php-fpm php-mysql wget default-mysql-client curl php-cli php-zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/php && mkdir -p /var/www/html

# Télécharger et installer WordPress
RUN wget --no-check-certificate https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    chown -R www-data:www-data /var/www/html

# Télécharger et installer WP-CLI
RUN wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copier le fichier de configuration PHP-FPM
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copier le script de démarrage de WordPress
COPY ./tools/runWordPress.sh ./runWordPress.sh

# Modifier les configurations PHP pour PHP-FPM
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/cli/php.ini && \
    sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php/7.4/fpm/pool.d/www.conf

# Exposer le port 9000 pour PHP-FPM
EXPOSE 9000

# Définir le CMD par défaut pour démarrer le script et PHP-FPM
CMD ["/runWordPress.sh", "php-fpm7.4"]
