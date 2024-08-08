# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yeolee2 <yeolee2@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/08 16:34:35 by yeolee2           #+#    #+#              #
#    Updated: 2024/08/08 17:36:14 by yeolee2          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS			=	SRCS

DOCKER_COMPOSE	:=	$(shell if command -v docker-compose >/dev/null 2>&1; \
					then echo "docker-compose"; else echo "docker compose"; fi)

all				:	dir
					@sudo -E ${DOCKER_COMPOSE} -f ./${SRCS}/docker-compose.yml up -d

build			:	dir
					@sudo -E ${DOCKER_COMPOSE} -f ./${SRCS}/docker-compose.yml up -d --build

down			:
					@sudo -E ${DOCKER_COMPOSE} -f ./${SRCS}/docker-compose.yml down -v

re				:	clean	
					@sudo -E ${DOCKER_COMPOSE} -f ./${SRCS}/docker-compose.yml up -d

dir				:
					@bash ${SRCS}/init_dir.sh

clean			:	down
					@sudo -E docker image ls | grep '${SRCS}-' | awk '{print $$1}' | xargs docker image rm

fclean			:	down
					@sudo -E docker image ls | grep '${SRCS}-' | awk '{print $$1}' | xargs docker image rm
					@sudo -E docker builder prune --all --force
					@sudo -E docker network prune --force
					@sudo -E docker volume prune --force
					@bash ${SRCS}/init_dir.sh --delete

.PHONY			:	all build down re clean fclean dir