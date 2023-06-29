FROM alpine:3.15

RUN apk update && apk upgrade && apk add --no-cache vim vsftpd
ADD conf/vftp.tgz /etc/vsftpd/
ADD tools/* /usr/bin

CMD ["start"]

