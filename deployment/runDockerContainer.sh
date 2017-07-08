#!/bin/bash

DOCKER_REPO=localhost:5000/app
CONTAINER_NAME=app
SERVICE_NAME=demo_app/v1

containerId=`docker ps -qa --filter "name=$CONTAINER_NAME"`
if [ -n "$containerId" ]
then
	echo "Stopping and removing existing container"
	docker stop $CONTAINER_NAME
	docker rm -f $CONTAINER_NAME
fi

docker pull $DOCKER_REPO
docker run -d --name $CONTAINER_NAME -e SERVICE_NAME=$SERVICE_NAME -e SERVICE_TAGS=rest -p :3000 $DOCKER_REPO

