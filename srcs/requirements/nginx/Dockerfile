FROM alpine:3.15

RUN apk update && apk upgrade && apk add --no-cache vim nginx openssl

ADD tools/* /usr/bin/
RUN configure

CMD ["start"]

