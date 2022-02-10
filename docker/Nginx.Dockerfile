FROM nginx:1.20-alpine

# apline based = ubuntu => apk istead apt
RUN apk update && apk add openssl
RUN rm /etc/nginx/conf.d/default.conf && mkdir -p /var/www/html

RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 &&\
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/self.key -out /etc/ssl/certs/self.crt \
    -subj "/C=RU/ST=Moscow/L=Kremlin/O=Azzrael Code/OU=Org/CN=azz.code"

COPY docker/conf/vhost.conf /etc/nginx/conf.d
COPY docker/conf/ssl-params.conf /etc/nginx/ssl-params.conf


WORKDIR /var/www/html