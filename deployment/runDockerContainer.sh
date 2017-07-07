#! /bin/bash

DOCKER_REPO=localhost:5000/microservice-app
TAG=0.0.1-SNAPSHOT
CONTAINER_NAME=microservice-app

containerId=`docker ps -qa --filter "name=$CONTAINER_NAME"`
if [ -n "$containerId" ]
then
	echo "Stopping and removing existing container"
	docker stop $CONTAINER_NAME
	docker rm -f $CONTAINER_NAME
fi

docker pull $DOCKER_REPO
docker run -d --name $CONTAINER_NAME -e SERVICE_NAME=hello_service/v1 -e SERVICE_TAGS=rest -p :3000 $DOCKER_REPO
#docker run -d --name $CONTAINER_NAME -p 9090:8080 $DOCKER_REPO:$TAG
#use -d to run in background
#use -it to run in foreground and get the output. add --rm to remove the container (container's file system) when it exits.

