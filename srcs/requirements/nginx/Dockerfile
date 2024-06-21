FROM debian:bullseye-slim

# Installer NGINX et OpenSSL
RUN apt-get update && \
	apt-get install -y nginx openssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Copier les fichiers de configuration et les certificats
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/certificates /etc/nginx/certificates

# Exposer le port 443
EXPOSE 443

# Commande pour demarrer NGINX
CMD [¨nginx¨, ¨-g¨, ¨daemon off;¨]
