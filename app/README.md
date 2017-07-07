Service Discovery 
http://sirile.github.io/2015/05/18/using-haproxy-and-consul-for-dynamic-service-discovery-on-docker.html

Commands to Setup
docker-machine create -d virtualbox microservices
eval "$(docker-machine env microservices)"

run consul( change the ips and hostname)
docker run --name consul -d -h microservices -p `docker-machine ip $DOCKER_MACHINE_NAME`:8300:8300 -p `docker-machine ip $DOCKER_MACHINE_NAME`:8301:8301 -p `docker-machine ip $DOCKER_MACHINE_NAME`:8301:8301/udp -p `docker-machine ip $DOCKER_MACHINE_NAME`:8302:8302 -p `docker-machine ip $DOCKER_MACHINE_NAME`:8302:8302/udp -p `docker-machine ip $DOCKER_MACHINE_NAME`:8400:8400 -p `docker-machine ip $DOCKER_MACHINE_NAME`:8500:8500 -p `docker-machine ip $DOCKER_MACHINE_NAME`:53:53 -p `docker-machine ip $DOCKER_MACHINE_NAME`:53:53/udp progrium/consul -server -advertise `docker-machine ip $DOCKER_MACHINE_NAME` -bootstrap-expect 1

start registrator
docker run -d -v /var/run/docker.sock:/tmp/docker.sock -h registrator --name registrator gliderlabs/registrator consul://`docker-machine ip $DOCKER_MACHINE_NAME`:8500

start a sample service
docker run -d -e SERVICE_NAME=hello/v1 -e SERVICE_TAGS=rest -h hello1 --name hello1 -p :80 sirile/scala-boot-test

testing the config
docker run --dns `docker-machine ip $DOCKER_MACHINE_NAME` --rm sirile/haproxy -consul=consul.service.consul:8500 -dry -once

running haproxy for real
docker run -d -e SERVICE_NAME=rest --name=rest --dns `docker-machine ip $DOCKER_MACHINE_NAME` -p 80:80 -p 1936:1936 sirile/haproxy

build hello service 
docker build -t hello-service .

run hello service
docker run -d -e SERVICE_NAME=hello_service/v1 -e SERVICE_TAGS=rest -p :3000 hello-service

/////////////////////////////////////////////////////////////////////////////////////////
run docker registry
docker run -d -p 5000:5000 --name registry registry:2

docker registry commands
https://docs.docker.com/registry/

start git project 
mkdir /path/to/your/project
cd /path/to/your/project
git init
git remote add origin https://pubuduwelagedara@bitbucket.org/pubuduwelagedara/microservice-app.git

add contributors
echo "pubudu welagedara" >> contributors.txt
git add contributors.txt
git commit -m 'Initial commit with contributors'
git push -u origin master

if you already have a git project 
cd /path/to/my/repo
git remote add origin https://pubuduwelagedara@bitbucket.org/pubuduwelagedara/microservice-app.git
git push -u origin --all # pushes up the repo and its refs for the first time
git push origin --tags # pushes up any tags

/////////////////////////////////////////////////////////////////////////////////////////

use dood for jenkins
/////////////////////////////////////////////////////////////////////////////////////////

DONT USE THIS
https://hub.docker.com/r/psharkey/jenkins-dood/

http://stackoverflow.com/questions/34352436/docker-build-and-publish-plugin-usage
/////////////////////////////////////////////////////////////////////////////////////////

USE THIS
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -v /path/to/your/jenkins/home:/var/jenkins_home -p 8088:8080 axltxl/jenkins-dood

add jenkins to sudoers group ( you will not be able to run docker commands otherwise) -http://askubuntu.com/questions/124166/how-do-i-add-myself-into-the-sudoers-group
http://stackoverflow.com/questions/33802424/build-step-execute-shell-marked-build-as-failure
echo 'jenkins ALL=(ALL) ALL' >> /etc/sudoers


install build pipeline plugin for jenkins
create a view 

/////////////////////////////////////////////////////////////////////////////////////////
export/ load docker images
http://tuhrig.de/difference-between-save-and-export-in-docker/
/////////////////////////////////////////////////////////////////////////////////////////






