NAME	=	inception


.PHONY: all
all:	prune reload

.PHONY: linux
.SILENT: linux
linux:
	echo "127.0.0.1 rnavarre.42.fr" >> /etc/hosts

.PHONY: stop
.SILENT: stop
stop:
	docker-compose -f srcs/docker-compose.yml down

.PHONY: clean
.SILENT: clean
clean:	stop
	echo stopping

.PHONY: prune
.SILENT: prune
prune:	clean
	docker system prune -f

.PHONY: reload
.SILENT: reload
reload:
	docker-compose -f srcs/docker-compose.yml up --build
