#!/bin/bash

set -e

# ---- Input validation ----
if [ -z "$1" ]; then
  echo "Usage: $0 <log_directory>"
  exit 1
fi

LOG_DIR="$1"

if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory '$LOG_DIR' does not exist."
  exit 1
fi

# ---- Configuration ----
#ARCHIVE_BASE_DIR="$HOME/log_archives"
ARCHIVE_BASE_DIR="./log_archives"
ARCHIVE_LOG_FILE="$ARCHIVE_BASE_DIR/archive.log"

# ---- Timestamp ----
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# ---- Prepare archive directory ----
mkdir -p "$ARCHIVE_BASE_DIR"

ARCHIVE_NAME="logs_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="$ARCHIVE_BASE_DIR/$ARCHIVE_NAME"

# ---- Create archive ----
tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" .

# ---- Log archive event ----
echo "$(date '+%Y-%m-%d %H:%M:%S') - Created archive '$ARCHIVE_PATH' from '$LOG_DIR'" \
>> "$ARCHIVE_LOG_FILE"

# ---- Output ----
echo "Archive created: $ARCHIVE_PATH"

# ---- List the contents of .tar.gz file ----
echo "Contents of $ARCHIVE_PATH:"
tar -tzf $ARCHIVE_PATH
