#! /bin/bash

DOCKER_REPO=localhost:5000/microservice-app
TAG=0.0.1-SNAPSHOT
CONTAINER_NAME=microservice-app-acceptance
SERVICE_NAME=hello_service_acceptance/v1
ENDPOINT=http://ec2-52-48-105-34.eu-west-1.compute.amazonaws.com:88/hello_service_acceptance/v1

containerId=`docker ps -qa --filter "name=$CONTAINER_NAME"`
if [ -n "$containerId" ]
then
	echo "Stopping and removing existing container"
	docker stop $CONTAINER_NAME
	docker rm -f $CONTAINER_NAME
fi

docker pull $DOCKER_REPO
docker run -d --name $CONTAINER_NAME -e SERVICE_NAME=$SERVICE_NAME -e SERVICE_TAGS=rest -p :3000 $DOCKER_REPO

#Give 5 seconds for consul to register
sleep 30

OUTPUT="$(curl -Is $ENDPOINT | head -1)"
echo "${OUTPUT}"

if [[ ${OUTPUT} = *"200"* ]];then
    echo "Acceptance test passed"
else
    echo "Acceptance test failed"
    exit 1
fi

#Command to get exposed ports: docker port test 7890/tcp
