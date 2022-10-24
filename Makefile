NAME		=	inception
DCPATH		=	srcs/
DCFILE		=	docker-compose.yml
DCCONFIG	=	$(addprefix $(DCPATH), $(DCFILE))
DCFLAGS		=	-f
DC			=	docker compose $(DCFLAGS) $(DCCONFIG)

CURDIR		=	$(abspath .)

WT_SP		=	$(WT) sp

all:	prune reload

linux:
	echo "127.0.0.1 rnavarre.42.fr" >> /etc/hosts

stop:
	$(DC) down

start:
	$(DC) up

clean:	stop
	echo stopping

prune:	clean
	docker system prune -f

reload:
	$(DC) up -d --build

mysql:
	$(WT_SP) wsl --exec bash -c "/usr/bin/vim $(CURDIR)/srcs/requirements/mysql/Dockerfile"

logs:
	$(DC) logs --follow

print:
	echo $(DCPATH)
	echo $(DCFILE)
	echo $(DC)

.PHONY: clean fclean all prune reload start stop linux logs
.SILENT: clean fclean print
