#!/usr/bin/env bash

RUNTIME_DIR="/var/www/html/leadworks/protected/runtime"
ASSETS_DIR="/var/www/html/leadworks/assets"
DATA_TOOLS_MIGRATION_PATH="application.modules.dataTools.migrations"
MEDIA_PLANNER_MIGRATION_PATH="application.modules.mediaPlanner.migrations"
YII2_DIR="/var/www/html/leadworks/protected/basic"
YII2_RBAC_MIGRATION_PATH="@yii/rbac/migrations"
YII2_MEDIA_PLANNER_MIGRATION_PATH="modules/mediaPlanner/migrations"
PROTECTED_DIR="/var/www/html/leadworks/protected"
OLD_ANGULAR_DIR="/var/www/html/leadworks/js/angularjs"

chown -R www-data "$RUNTIME_DIR"

mkdir -p "$ASSETS_DIR" && chown -R www-data "$ASSETS_DIR"

# Ensure correct permissions on runtime directory
# Make sure excel dir exists
mkdir -p ${PROTECTED_DIR}/runtime/excel
cd ${PROTECTED_DIR} && chgrp -R www-data runtime && chmod -R 775 runtime
cd ${YII2_DIR} && chgrp -R www-data web/assets && chmod -R 775 web/assets

# Ensure correct permissions on Yii2 runtime directory
mkdir -p ${YII2_DIR}/runtime
cd ${YII2_DIR} && chgrp -R www-data runtime && chmod -R 775 runtime

# Ensure Yii2 assets directory exists
cd ${YII2_DIR}/web && mkdir -p assets && chgrp -R www-data assets && chmod -R 775 assets

# Ensure Yii2 cache directory exists
cd ${YII2_DIR}/runtime && mkdir -p cache && chown -R www-data:www-data cache && chmod -R 775 cache

# Ensure correct permissions on MP directories for files uploads
cd ${PROTECTED_DIR}/modules/mediaPlanner && chgrp -R www-data files && chmod -R 775 files

# Ensure correct permissions on PAN directories for files uploads
cd ${PROTECTED_DIR}/assets && mkdir -p audience-network && chgrp -R www-data audience-network && chmod -R 775 audience-network

# Run composer install
if [[ "$ENV" == "prod" ]];then
    cd ${PROTECTED_DIR} && composer install --no-ansi --no-dev --no-interaction --no-progress --no-scripts --optimize-autoloader --apcu-autoloader
else
    cd ${PROTECTED_DIR} && composer install --no-ansi --no-interaction --no-progress --no-scripts
fi

# Run migration in Yii1 app
cd ${PROTECTED_DIR} && ./yiic migrate up --interactive=0

# Run migration in data tools module
cd ${PROTECTED_DIR} && ./yiic migrate up --interactive=0 --migrationPath=${DATA_TOOLS_MIGRATION_PATH}

# Run migration in media planner module
cd ${PROTECTED_DIR} && ./yiic migrate up --interactive=0 --migrationPath=${MEDIA_PLANNER_MIGRATION_PATH}

# Run migration in yii2 app
cd ${YII2_DIR} && ./yii migrate --interactive=0

# Run migration for rbac in yii2
cd ${YII2_DIR} && ./yii migrate --interactive=0 --migrationPath=${YII2_RBAC_MIGRATION_PATH}

# Run migration for media planner in yii2
cd ${YII2_DIR} && ./yii migrate --interactive=0 --migrationPath=${YII2_MEDIA_PLANNER_MIGRATION_PATH}

# Install bower dependencies
cd ${OLD_ANGULAR_DIR} && bower install
