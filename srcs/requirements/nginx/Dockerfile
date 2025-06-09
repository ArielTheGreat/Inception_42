FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx openssl curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/nginx/ssl/nginx.key \
-out /etc/nginx/ssl/nginx.crt \
-subj "/C=DE/ST=Baden-Wurttemberg/L=Heilbronn/O=42Heilbronn/OU=Student/CN=frocha.42.fr"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443 80

CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]