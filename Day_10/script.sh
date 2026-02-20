#!/bin/bash
set -euo pipefail

SRC_DIR="/var/www/html/blog"
LOCAL_BACKUP_DIR="/backup"
ARCHIVE_NAME="xfusioncorp_blog.zip"
LOCAL_ARCHIVE_PATH="${LOCAL_BACKUP_DIR}/${ARCHIVE_NAME}"

REMOTE_USER="clint"
REMOTE_HOST="172.16.238.16"
REMOTE_DIR="/backup"

# Ensure source exists
if [[ ! -d "$SRC_DIR" ]]; then
  echo "ERROR: Source directory not found: $SRC_DIR"
  exit 1
fi

# Ensure local backup directory exists
mkdir -p "$LOCAL_BACKUP_DIR"

# Create zip archive (from inside /var/www/html so the zip contains blog/...)
cd /var/www/html
rm -f "$LOCAL_ARCHIVE_PATH"
zip -r "$LOCAL_ARCHIVE_PATH" "blog" >/dev/null

# Copy to Nautilus Backup Server (must be passwordless via SSH keys)
scp -q "$LOCAL_ARCHIVE_PATH" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"

echo "Backup completed:"
echo " - Local:  $LOCAL_ARCHIVE_PATH"
echo " - Remote: ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/${ARCHIVE_NAME}"2: /scripts/blog_backup.sh

