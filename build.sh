#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' Private/.env | xargs)

docker_image_name="router-satellite-alpine-linux"
docker_image_platform="arm32"
container_file_path=./nginx-static/container/$docker_image_name-$docker_image_platform.tar

# Remove existing container file if it exists
if [ -f $container_file_path ]; then
    rm $container_file_path
fi

mkdir -p ./nginx-static/container/

# Build the Docker image using the environment variables
docker buildx build --platform linux/arm -t $docker_image_name:$docker_image_platform \
    --build-arg CONTAINER_INTERNAL_SSH_PORT=${CONTAINER_INTERNAL_SSH_PORT} \
    --build-arg CONTAINER_SSH_FILE_NAME=${ROUTER_SSH_FILE_NAME} \
    --build-arg ROUTER_SSH_IP=${ROUTER_SSH_IP} \
    --build-arg ROUTER_SSH_PORT=${ROUTER_SSH_PORT} \
    --build-arg ROUTER_SSH_FILE_NAME=${ROUTER_SSH_FILE_NAME} .

# Save the Docker image to a file
docker save $docker_image_name > $container_file_path