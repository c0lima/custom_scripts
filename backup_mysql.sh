#!/usr/bin/env bash


# To use MYSQL encrypted password
source db_auth.cfg

# Set the folder name formate with date (2022-05-28)

DATE_FORMAT=$(date +"%Y-%m-%d")

# MySQL server credentials
MYSQL_HOST="localhost"
MYSQL_PORT="3306"
MYSQL_USER="root"
MYSQL_PASSWORD=$(eval echo ${SQL_PASSWORD} | base64 -d)


# Path to local backup directory
LOCAL_BACKUP_DIR="/home/factoria/.backup/db_backup"

# Set s3 bucket name and directory path
S3_BUCKET_NAME="factoria-server"
S3_BUCKET_PATH="backups/mysql"

# Number of days to store local backup files
BACKUP_RETAIN_DAYS=30 

# Use a single database or space separated database's names
DATABASES="plat"

## Do not change below this line

mkdir -p ${LOCAL_BACKUP_DIR}/${DATE_FORMAT}

LOCAL_DIR=${LOCAL_BACKUP_DIR}/${DATE_FORMAT}
REMOTE_DIR=s3://${S3_BUCKET_NAME}/${S3_BUCKET_PATH}
REMOTE_DIR_DRIVE="1VS-_VYXzB0wHPi_2xuduiePTgh-41FZH"


for db in $DATABASES; do
   mysqldump \
        -h ${MYSQL_HOST} \
        -P ${MYSQL_PORT} \
        -u ${MYSQL_USER} \
        -p${MYSQL_PASSWORD} \
        --single-transaction ${db} | gzip -9 > ${LOCAL_DIR}/${db}-${DATE_FORMAT}.sql.gz

        aws s3 cp ${LOCAL_DIR}/${db}-${DATE_FORMAT}.sql.gz ${REMOTE_DIR}/${DATE_FORMAT}/
	gdrive upload --parent ${REMOTE_DIR_DRIVE} ${LOCAL_DIR}/${db}-${DATE_FORMAT}.sql.gz

done

DBDELDATE=`date +"${DATE_FORMAT}" --date="${BACKUP_RETAIN_DAYS} days ago"`

if [ ! -z ${LOCAL_BACKUP_DIR} ]; then
 cd ${LOCAL_BACKUP_DIR}
 if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
 rm -rf ${DBDELDATE}

 fi
fi
