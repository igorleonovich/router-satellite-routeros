#!/bin/sh

  SCRIPT_PATH=$(realpath $0)
  PROJECT_PATH=$(dirname $SCRIPT_PATH)

  docker compose -f ${PROJECT_PATH}/docker-compose.yml \
    --env-file ${PROJECT_PATH}/Private/.env \
    --project-name "router-satellite-routeros" \
    up -d
