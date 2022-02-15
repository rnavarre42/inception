FROM alpine:3.13

RUN apk update && apk upgrade && apk add --no-cache nginx openssl openssh openrc
RUN rc-update add sshd
#RUN /etc/init.d/sshd start

ENTRYPOINT ["sh"]
#ENTRYPOINT ["nginx", "-g", "daemon off;"]

