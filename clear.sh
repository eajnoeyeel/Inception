#!/bin/bash

# --DS 옵션을 사용하면 .DS_Store 파일을 삭제하고 스크립트를 종료
if [ "$1" == "--DS" ]; then
    find . -name ".DS_Store" | xargs rm -f
    echo "Deleted .DS_Store"
    exit 0
fi

# Docker Compose 다운
docker compose down

# 모든 'srcs-'로 시작하는 컨테이너 제거
docker ps -a | grep srcs- | awk '{print $1}' | xargs docker rm -f 

# 모든 'srcs-'로 시작하는 이미지 제거
docker image ls | grep srcs- | awk '{print $3}' | xargs docker image rm -f

# 모든 Docker 볼륨 제거
docker volume ls | awk '{print $2}' | xargs docker volume rm -f

# Docker 시스템 전체 정리 (모든 이미지, 컨테이너, 네트워크 제거)
docker system prune --all --force

# mariadb_data 디렉토리 삭제 및 재생성
sudo rm -rf /Users/iyeonjae/Desktop/Inception/srcs/mariadb_data
mkdir /Users/iyeonjae/Desktop/Inception/srcs/mariadb_data

# wordpress_data 디렉토리 삭제 및 재생성
sudo rm -rf /Users/iyeonjae/Desktop/Inception/srcs/wordpress_data
mkdir /Users/iyeonjae/Desktop/Inception/srcs/wordpress_data

# 완료 메시지 출력
echo "done"