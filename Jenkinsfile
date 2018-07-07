
node {
   stage 'Build'
   		echo 'Building the app'
   		git credentialsId: '15390682-b3f8-4a91-9cec-7684d7cb7b2a', url: 'https://github.com/welagedara/ci-n-cd.git'
   		sh 'docker rmi localhost:5000/app || ls'
   		sh 'docker rmi $(docker images | grep "^<none>" | awk "{print $3}") || ls'
   		//sh 'docker rmi $(sudo docker images -f "dangling=true" -q) || ls'
   		sh 'cd app && docker build -t app .'
   		sh 'docker tag app localhost:5000/app'
   		sh 'docker push localhost:5000/app'
   stage 'Acceptance Test'
   		echo 'Running acceptance test'
        sh 'cd acceptance && ./runAcceptanceTest.sh'
   stage 'Deployment'
		echo 'Running deplyment'
        sh 'cd deployment && ./runDockerContainer.sh'
}
