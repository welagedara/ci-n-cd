#!/bin/bash

DOCKER_REPO=localhost:5000/app
TAG=0.0.1-SNAPSHOT
CONTAINER_NAME=acceptance
SERVICE_NAME=demo_acceptance/v1
ENDPOINT=http://52.179.157.125/demo_acceptance/v1

containerId=`docker ps -qa --filter "name=$CONTAINER_NAME"`
if [ -n "$containerId" ]
then
	echo "Stopping and removing existing container"
	docker stop $CONTAINER_NAME
	docker rm -f $CONTAINER_NAME
fi

docker pull $DOCKER_REPO
docker run -d --name $CONTAINER_NAME -e SERVICE_NAME=$SERVICE_NAME -e SERVICE_TAGS=rest -p :3000 $DOCKER_REPO

# Give  seconds for consul to register
sleep 60

OUTPUT="$(curl -Is $ENDPOINT | head -1)"
echo "${OUTPUT}"

if [[ ${OUTPUT} = *"200"* ]];then
    echo "Acceptance test passed"
else
    echo "Acceptance test failed"
    exit 1
fi
