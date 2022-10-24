FROM alpine:3.14

RUN apk update && apk upgrade && apk add --no-cache nginx openssl openssh openrc
RUN rc-update add sshd

WORKDIR /run/openrc
RUN touch softlevel && \
	openrc

RUN /etc/init.d/sshd start

#ENTRYPOINT ["sh"]
ENTRYPOINT ["nginx", "-g", "daemon off;"]

