#!/bin/bash
# Written with Gemini Pro 3.1 on 2026-06-13.

# 1. Check if BOTH arguments (YEAR and TARGET_DIR) are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Missing arguments."
    echo "Usage: ./apply-copyright.sh YEAR /path/to/images"
    exit 1
fi

YEAR="$1"
TARGET_FOLDER="$2"

# Store long strings in variables to strictly respect the 72-col wrap
CP_TEXT="© $YEAR Fat Cat Pets. All rights reserved."
OWNER="Fat Cat Pets"
URL="https://www.fatcatpets.com"

echo "Applying $YEAR copyright to photos in: $TARGET_FOLDER..."

# 2. Run ExifTool targeting EXIF, XMP, and IPTC tags.
# The -r flag tells ExifTool to recursively check all subfolders.
exiftool -r -charset EXIF=UTF8 -charset IPTC=UTF8 \
  -CodedCharacterSet=utf8 \
  -Copyright="$CP_TEXT" \
  -Artist="$OWNER" \
  -XMP-dc:Rights="$CP_TEXT" \
  -XMP-xmpRights:CopyrightNotice="$CP_TEXT" \
  -XMP-xmpRights:WebStatement="$URL" \
  -XMP-dc:Creator="$OWNER" \
  -IPTC:CopyrightNotice="$CP_TEXT" \
  -IPTC:By-line="$OWNER" \
  -IPTC:Credit="$OWNER" \
  "$TARGET_FOLDER"

# 3. Rename default "_original" backups to ".backup"
# The find command naturally recurses through all subfolders.
echo "Renaming backup files to end in .backup..."
find "$TARGET_FOLDER" -type f -name "*_original" \
  -exec sh -c 'mv "$1" "${1%_original}.backup"' sh {} \;

echo "Done! Copyright and backups successfully applied."
