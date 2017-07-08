
node {
   stage 'Build'
   		echo 'Building the app'
   		git credentialsId: '9651666f-774b-4077-add8-98f14eebd337', url: 'https://github.com/station1-demo-org/microservice.git'
   		sh 'sudo docker rmi localhost:5000/app || ls'
   		sh 'sudo docker rmi $(sudo docker images -f "dangling=true" -q) || ls'
   		sh 'cd app && sudo docker build -t app .'
   		sh 'sudo docker tag -f app localhost:5000/app'
   		sh 'sudo docker push localhost:5000/app'
   stage 'Acceptance Test'
   		echo 'Running acceptance test'
        sh 'cd acceptance && sudo ./runAcceptanceTest.sh'
   stage 'Deployment'
   		echo 'Hello World 2'
        sh 'ls'
}