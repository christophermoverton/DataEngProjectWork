#!/bin/bash

# Database credentials
DB_USER="testuser"
DB_PASSWORD="password"
DB_NAME="Sample"

# Timestamp for the backup file
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Backup directory
BACKUP_DIR="./"

# Create the backup
mysqldump -u$DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_DIR/backup_$TIMESTAMP.sql

# Optionally compress the backup
gzip $BACKUP_DIR/backup_$TIMESTAMP.sql

echo "Backup completed: $BACKUP_DIR/backup_$TIMESTAMP.sql.gz"
