NAME				=	inception
DCPATH				=	srcs/
DCFILE				=	docker-compose.yml
DCCONFIG			=	$(addprefix $(DCPATH), $(DCFILE))
DCFLAGS				=	-f
DC					=	$(DOCKER) compose $(DCFLAGS) $(DCCONFIG)
DOCKER				=	docker
CURDIR				=	$(abspath .)
VOLUME_PATH			=	$(USER)/data/
WORDPRESS_NAME		=	wordpress
MARIADB_NAME		=	mariadb
NGINX_NAME			=	nginx
FTP_NAME			=	ftp
TEST_NAME			=	test
WORDPRESS_VOLUME	=	$(addprefix $(VOLUME_PATH), $(WORDPRESS_NAME))
MARIADB_VOLUME		=	$(addprefix $(VOLUME_PATH), $(MARIADB_NAME))
VOLUMES				=	$(WORDPRESS_VOLUME) $(MARIADB_VOLUME)
CONTAINERS			=	$(WORDPRESS_NAME) $(MARIADB_NAME) $(NGINX_NAME) $(FTP_NAME) $(TEST_NAME)

# WSL Windows Terminal manipulation
WT_SP				=	$(WT) sp


all:	prune reload

linux:
	sudo echo "127.0.0.1 rnavarre.42.fr" >> /etc/hosts

down:
	$(DC) down

up:
	$(DC) up -d

clean:	down
	echo stopping

fclean:	clean
	$(DC) down -v --rmi "local"

wordpress_clean:
	$(DC) down wordpress -v --rmi "local"

volumes:	$(VOLUMES)

$(CONTAINERS):
	$(DC) up -d $@ --build

$(VOLUMES):
	mkdir -p $@

#prune:	clean
#	$(DOCKER) system prune -f

reload:
	$(DC) up -d --build

edit:
	$(WT_SP) -H wsl --exec bash -c "/usr/bin/vim $(CURDIR)/srcs/requirements/mariadb/Dockerfile;"	\
	mf --direction up \; \
	sp -V wsl --exec bash -c "/usr/bin/vim $(CURDIR)/srcs/requirements/nginx/Dockerfile;"		\
	mf --direction down \; \
	sp -V wsl --exec bash -c "/usr/bin/vim $(CURDIR)/srcs/requirements/wordpress/Dockerfile"

logs:
	$(DC) logs --follow

print:
	echo $(DCPATH)
	echo $(DCFILE)
	echo $(DC)

.PHONY: clean fclean all prune reload start stop linux logs
.SILENT: clean fclean print
