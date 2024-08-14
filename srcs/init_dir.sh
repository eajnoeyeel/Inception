#!/bin/bash

ENV_FILE="srcs/.env"

# OS에 따라 BASE_DIR 설정
if [ "$(uname)" == "Darwin" ]; then
    # macOS
    BASE_DIR="/Users/$USER/data"
else
    # Linux
    BASE_DIR="/home/$USER/data"
fi

# 볼륨 삭제 처리
if [ "$2" == "--delete" ]; then
    echo "Deleting volumes..."
    rm -rf "$BASE_DIR"
    echo "Delete COMPLETE"

    if [ -f "$ENV_FILE" ]; then
        sed -i '/^DATA_PATH=/d' "$ENV_FILE"
    else
        echo ".env file not found. Skipping DATA_PATH removal."
    fi
    exit 0
fi

# 볼륨 추가 처리
if [ ! -d "$BASE_DIR" ]; then
    echo "Adding volumes..."
    mkdir -p $BASE_DIR/wordpress/
    mkdir -p $BASE_DIR/mariadb/

    # BASE_DIR 디렉토리의 소유자를 현재 사용자로 변경
    chown -R $USER:$USER $BASE_DIR
    echo "Add COMPLETE"
fi

if [ -f "$ENV_FILE" ]; then
    sed -i '/^DATA_PATH=/d' "$ENV_FILE"
else
    echo ".env file not found. Skipping DATA_PATH removal."
fi

# .env 파일에 DATA_PATH 추가
if ! grep -q "DATA_PATH=" "$ENV_FILE"; then
    if [ -s "$ENV_FILE" ] && [ "$(tail -c 1 "$ENV_FILE" | wc -l)" -eq 0 ]; then
        echo "" >> "$ENV_FILE"
    fi
    echo "DATA_PATH=$BASE_DIR" >> "$ENV_FILE"
fi