#!/bin/sh



# Path to local backup directory
LOCAL_DATA_DIR="/home/factoria/Desktop/plataforma-kuskalla/data"
LOCAL_BACKUP_DIR="/home/factoria/.backup/kuskalla"
DATE_FORMAT=$(date +"%Y-%m-%d")
REMOTE_DRIVE_FOLDER="13ZV2FKtPBcGpBmRqqVShzkURLIoGj2a-" #server-db-backups/kuskalla
LOCAL_DIR=${LOCAL_BACKUP_DIR}/${DATE_FORMAT}


7z a ${LOCAL_BACKUP_DIR}/${DATE_FORMAT}.zip ../../.${LOCAL_DATA_DIR}
gdrive upload --parent ${REMOTE_DRIVE_FOLDER} ${LOCAL_BACKUP_DIR}/${DATE_FORMAT}.zip

