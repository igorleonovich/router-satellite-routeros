#!/bin/bash

docker_image_name="router-satellite-alpine-linux"
docker_image_platform="arm32"

docker buildx build --platform linux/arm -t $docker_image_name:$docker_image_platform .
docker save $docker_image_name > $docker_image_name-$docker_image_platform.tar