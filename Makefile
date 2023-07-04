NAME				=	inception
DCPATH				=	srcs/
DCFILE				=	docker-compose.yml
DCCONFIG			=	$(addprefix $(DCPATH), $(DCFILE))
DCFLAGS				=	-f
DC					=	$(DOCKER) compose $(DCFLAGS) $(DCCONFIG)
DOCKER				=	docker
CURDIR				=	$(abspath .)
VOLUME_PATH			=	~$(USER)/data/
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


all:	linux-hosts reload

linux-hosts:
	if ! grep -q "127.0.0.1 rnavarre.42.fr" /etc/hosts; then \
		sudo bash -c "echo 127.0.0.1 rnavarre.42.fr >> /etc/hosts"; \
	fi

down:
	$(DC) down

up:
	$(DC) up -d

clean:	down
	echo stopping

fclean:	clean
	$(DC) down -v --rmi "local"
	sudo rm -Rf $(WORDPRESS_VOLUME)
	sudo rm -Rf $(MARIADB_VOLUME)

wordpress_clean:
	$(DC) down wordpress -v --rmi "local"

volumes:	$(VOLUMES)

$(CONTAINERS):
	$(DC) up -d $@ --build

$(VOLUMES):
	mkdir -p $@

reload:		$(VOLUMES)
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

.PHONY: clean fclean all reload start stop linux logs
.SILENT: clean fclean print linux-hosts
