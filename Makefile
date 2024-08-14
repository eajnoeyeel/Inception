# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yeolee2 <yeolee2@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/08 16:34:35 by yeolee2           #+#    #+#              #
#    Updated: 2024/08/13 13:16:29 by yeolee2          ###   ########seoul.kr   #
#                                                                              #
# **************************************************************************** #

SRCS			=	srcs

DOCKER_COMPOSE	:=	$(shell if command -v docker-compose >/dev/null 2>&1; \
					then echo "docker-compose"; else echo "docker compose"; fi)

all				:	dir
					@${DOCKER_COMPOSE} -f ./${SRCS}/docker-compose.yml up -d

build			:	dir
					@${DOCKER_COMPOSE} -f ./${SRCS}/docker-compose.yml up -d --build

down			:
					@${DOCKER_COMPOSE} -f ./${SRCS}/docker-compose.yml down -v

re				:	clean
					@${DOCKER_COMPOSE} -f ./${SRCS}/docker-compose.yml up -d

dir				:
					@bash ${SRCS}/init_dir.sh

clean			:	down
					@docker system prune --all --force

fclean			:	clean
					@docker system prune --all --force --volumes
					@docker network prune --force
					@docker volume prune --force
					@sudo rm -rf ~/data/wordpress/*
					@sudo rm -rf ~/data/mariadb/*

.PHONY			:	all build down re clean fclean dir