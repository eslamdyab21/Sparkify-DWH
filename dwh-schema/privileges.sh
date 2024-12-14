#!/bin/bash
echo "Substituting environment variables in privileges.sql..."

source /dwh/.env


TMPFILE=$(mktemp)

sed -e "s|\${DWH_USER}|${DWH_USER}|g" \
    -e "s|\${DWH_PASSWORD}|${DWH_PASSWORD}|g" \
    -e "s|\${DWH_NAME}|${DWH_NAME}|g" \
    -e "s|\${STAGING_DWH_NAME}|${STAGING_DWH_NAME}|g" \
    /dwh/privileges.sql > $TMPFILE


mysql -u root -p${DWH_PASSWORD} < $TMPFILE

echo "create user ${DWH_USER} and gave it privileges successfully"
