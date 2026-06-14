#!/bin/bash
# Written with Gemini Pro 3.1 on 2026-06-14.

# 1. Check if the target directory argument is provided
if [ -z "$1" ]; then
    echo "Error: Missing target directory."
    echo "Usage: ./geotag-photos.sh /path/to/images"
    exit 1
fi

TARGET_FOLDER="$1"

# 2. Define the geographic and address data
LAT="57.137963"
LAT_REF="N"
LON="2.088913"
LON_REF="W"

BUSINESS="Fat Cat Pets"
STREET="11 Menzies Road"
CITY="Aberdeen"
POSTCODE="AB11 9AY"
COUNTRY="United Kingdom"

echo "Applying GPS and address data to photos in: $TARGET_FOLDER..."

# 3. Run ExifTool to write GPS, XMP, and IPTC location data
# We added standard tags specifically designed for Business/Venue names
exiftool -r \
  -GPSLatitude="$LAT" \
  -GPSLatitudeRef="$LAT_REF" \
  -GPSLongitude="$LON" \
  -GPSLongitudeRef="$LON_REF" \
  -XMP-iptcExt:LocationShownLocationName="$BUSINESS" \
  -IPTC:Sub-location="$BUSINESS" \
  -XMP:Location="$STREET" \
  -XMP:City="$CITY" \
  -XMP:PostalCode="$POSTCODE" \
  -XMP:Country="$COUNTRY" \
  -overwrite_original \
  "$TARGET_FOLDER"

echo "Done! All photos have been successfully geotagged."
