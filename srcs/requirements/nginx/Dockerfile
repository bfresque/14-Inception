FROM debian:bullseye

# Mettre à jour les paquets et installe Nginx et OpenSSL
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Définition des arguments pour la création du certificat SSL
ARG SSL_CERT_FOLDER
ARG SSL_CERT_PATH
ARG SSL_KEY_PATH
ARG COUNTRY
ARG STATE
ARG LOCALITY
ARG ORGANIZATION
ARG UNIT
ARG DOMAIN_NAME

# Crée le dossier pour les certificats SSL et certificat auto-signé
RUN mkdir -p ${SSL_CERT_FOLDER} && \
    openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -keyout ${SSL_KEY_PATH} \
    -out ${SSL_CERT_PATH} \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${DOMAIN_NAME}"

# Copie le fichier de configuration personnalisé de Nginx dans le conteneur
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Crée le dossier pour les fichiers web et change le propriétaire en www-data
RUN mkdir -p /var/www/
RUN chown -R www-data:www-data /var/www/

# Expose le port 443 pour les connexions HTTPS
EXPOSE 443

# Définit la commande par défaut pour démarrer Nginx en mode non-démon
CMD ["nginx", "-g", "daemon off;"]
