#!/bin/bash

SRC="/home/srv/"
DEST="/tmp/backup/"
LOG="$HOME/backup_home.log"   # локальный лог для удобства пользователя

# Создаём каталог назначения, если его нет
mkdir -p "$DEST"

# Запуск rsync
rsync -a --delete --checksum --exclude='.*/' --exclude='*/.*/' "$SRC" "$DEST"

# Проверяем результат выполнения rsync
if [ $? -eq 0 ]; then
    echo "$(date '+%F %T') Backup completed successfully" | tee -a "$LOG"
    logger -t backup-home "Backup completed successfully"
else
    echo "$(date '+%F %T') Backup failed" | tee -a "$LOG"
    logger -t backup-home "Backup failed"
fi
