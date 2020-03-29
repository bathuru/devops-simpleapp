node{
    stage('Git Checkout') {
        git url: 'https://github.com/bathurugithub/panda.git', branch: 'master'
    }

    stage(" Maven Build") {
      def mavenHome =  tool name: "Maven", type: "maven"
      sh "${mavenHome}/bin/mvn clean package"
    }

    stage('Build & Push Docker Image'){
            sh 'docker build -t bathurudocker/simpleapp:${BUILD_NUMBER} .'
            withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
              sh "docker login -u bathurudocker -p ${dockerpwd}"
            }
            sh 'docker push bathurudocker/simpleapp:${BUILD_NUMBER}'
            sh 'docker rmi bathurudocker/simpleapp:${BUILD_NUMBER}'
    }

    stage('Deploy Into PROD') {
       sshagent(['docker_Server_SSH']) {
           sh "ssh -o StrictHostKeyChecking=no ec2-user@52.66.240.70  sudo docker rm -f simpleapp || true"
           sh "ssh -o StrictHostKeyChecking=no ec2-user@52.66.240.70  sudo docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${BUILD_NUMBER}"
     }
     }
}
