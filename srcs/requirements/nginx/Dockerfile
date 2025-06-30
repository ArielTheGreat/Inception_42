FROM debian:bullseye

# Installiere Nginx, OpenSSL und Curl
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx openssl curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Erstelle das SSL-Verzeichnis und generiere Zertifikate
# Setze explizit Berechtigungen für das Verzeichnis und die Dateien
RUN mkdir -p /etc/nginx/ssl && \
    chmod 700 /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=DE/ST=Baden-Wurttemberg/L=Heilbronn/O=42Heilbronn/OU=Student/CN=frocha.42.fr" \
    && chmod 600 /etc/nginx/ssl/nginx.key \
    && chmod 600 /etc/nginx/ssl/nginx.crt

# Kopiere die Nginx-Konfiguration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Exponiere die Ports
EXPOSE 443 80

# Starte Nginx im Vordergrund
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

