# Debian 기반 이미지 사용
FROM debian:bullseye

# MariaDB 설치
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client

# MariaDB 설정 파일 복사
COPY ./conf/mariadb.cnf /etc/mysql/my.cnf

# 디렉토리 생성 및 권한 설정 (소켓 및 로그 파일)
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 755 /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql && \
    chmod 755 /var/log/mysql

# 초기화 스크립트와 SQL 파일을 컨테이너로 복사
COPY ./tools/init-db.sh /init-db.sh

# 초기화 스크립트에 실행 권한 부여
RUN chmod +x /init-db.sh

# MariaDB 서버 시작 및 초기화를 위한 ENTRYPOINT 설정
ENTRYPOINT [ "/init-db.sh" ]

CMD [ "mysqld" ]