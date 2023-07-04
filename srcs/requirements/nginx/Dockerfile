FROM alpine

ARG WORDPRESS_CERT_CRT
ARG WORDPRESS_CERT_KEY
ARG WORDPRESS_VIRTUAL_DOMAIN
ARG CERTS_PATH

RUN apk update && apk upgrade && apk add --no-cache nginx openssl curl

ADD conf/default.conf.template /etc/nginx/http.d/
ADD tools/* /usr/bin/
RUN configure

CMD ["entrypoint"]

