FROM alpine

RUN apk update && apk upgrade && apk add --no-cache \
		fcgi \
		mysql-client \
		php php-mysqli php-iconv php-phar php-curl php-json php-fpm

ADD tools/* /usr/bin/
ADD conf/www.conf.template /

WORKDIR /root

CMD ["entrypoint"]

