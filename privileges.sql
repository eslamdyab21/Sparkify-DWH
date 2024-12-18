-- Grant privileges
CREATE USER IF NOT EXISTS '${DWH_USER}'@'%' IDENTIFIED BY '${DWH_PASSWORD}';

GRANT ALL PRIVILEGES ON ${DWH_NAME}.* TO '${DWH_USER}'@'%';
GRANT ALL PRIVILEGES ON ${STAGING_DWH_NAME}.* TO '${DWH_USER}'@'%';

-- Apply changes
FLUSH PRIVILEGES;