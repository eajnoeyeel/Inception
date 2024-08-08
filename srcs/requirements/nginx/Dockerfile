# Debian bullseye 기반 이미지 사용
FROM debian:bullseye

# 환경변수를 통해 SSL 인증서 및 키 파일 설정
ARG CERT_KEY
ARG CERT_CRT

# Nginx 설정 파일 복사
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# 필요한 패키지 설치
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    nginx \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold"

# 웹 루트 디렉토리 생성 및 설정
RUN mkdir -p /var/www/html/wordpress/ && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/run/nginx && \
    mkdir -p /var/lib/nginx/var/run/ && \
    chmod -R 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html /var/log/nginx /var/run/nginx /var/lib/nginx/var/run/

# SSL 인증서 및 키 파일 설정
RUN mkdir -p /etc/nginx/ssl && \
    # echo -e "$CERT_KEY" > /etc/nginx/ssl/yeolee2.42.fr.key && \
    # echo -e "$CERT_CRT" > /etc/nginx/ssl/yeolee2.42.fr.crt && \
    printf "%s\n" "$CERT_KEY" > /etc/nginx/ssl/yeolee2.42.fr.key && \
    printf "%s\n" "$CERT_CRT" > /etc/nginx/ssl/yeolee2.42.fr.crt && \
    chmod 600 /etc/nginx/ssl/yeolee2.42.fr.key && \
    chmod 600 /etc/nginx/ssl/yeolee2.42.fr.crt && \
    chown www-data:www-data /etc/nginx/ssl/yeolee2.42.fr.key && \
    chown www-data:www-data /etc/nginx/ssl/yeolee2.42.fr.crt && \
    chown -R www-data:www-data /var/lib/nginx/

# Nginx 실행 (포그라운드에서 실행하여 컨테이너가 종료되지 않도록 함)
CMD ["nginx", "-g", "daemon off;"]