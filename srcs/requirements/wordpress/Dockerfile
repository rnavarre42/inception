FROM alpine:3.15

RUN apk update && apk upgrade && apk add --no-cache \
		mysql-client \
		php7 php7-mysqli php7-iconv php7-phar php7-curl php7-json php7-fpm

ADD tools/* /usr/bin/
RUN download-wp

CMD ["start"]

