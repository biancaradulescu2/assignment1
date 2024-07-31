#!/bin/bash

# MYSQL_HOST=${MYSQL_HOST:-db}
# MYSQL_USER=${MYSQL_USER:-myapp_user}
# MYSQL_PASSWORD=${MYSQL_PASSWORD:-example}
# MYSQL_DATABASE=${MYSQL_DATABASE:-myapp_db}
MYSQL_HOST=db
MYSQL_USER=myapp_user
MYSQL_PASSWORD=example
MYSQL_DATABASE=myapp_db

# MYSQL_HOST=root
# MYSQL_DATABASE=${MYSQL_DATABASE}
# MYSQL_USER=${MYSQL_USER}
# MYSQL_PASSWORD=${MYSQL_PASSWORD}

BACKUP_DIR=/backup
BACKUP_FILE="${BACKUP_DIR}/backup_$(date +%F_%T).sql"

mkdir $BACKUP_DIR

mysqldump -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > $BACKUP_FILE

if [ $? -eq 0 ]; then
    echo "Backup-ul a fost creat cu succes: $BACKUP_FILE"
else
    echo "Eroare la crearea backup-ului"
    exit 1
fi

find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -exec rm {} \;