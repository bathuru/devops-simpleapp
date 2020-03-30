def   VER_NUM;
def   REL_NUM;
def   mavenHome;
node{

    stage('Init') {
        VER_NUM = "1.0.${BUILD_NUMBER}";
        REL_NUM = "1.0.${BUILD_NUMBER}.RELEASE";
        mavenHome =  tool name: "Maven", type: "maven"
    }

    stage('Git Checkout') {
          git url: 'https://github.com/bathurugithub/simpleapp.git', branch: 'master'
    }

    stage("Maven Build") {
          sh "${mavenHome}/bin/mvn clean versions:set -Dver=${REL_NUM} package "
    }

   stage('SonarQube Analysis') {
         withSonarQubeEnv('SonarQubeServer') {
                 sh "${mavenHome}/bin/mvn sonar:sonar"
          }
     }

    stage('Build & Push Docker Image'){
            sh "docker build -t bathurudocker/simpleapp:${VER_NUM} ."
            withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
              sh "docker login -u bathurudocker -p ${dockerpwd}"
            }
            sh "docker push bathurudocker/simpleapp:${VER_NUM}"
            sh "docker rmi bathurudocker/simpleapp:${VER_NUM}"
    }

      stage('Deploy Into Dev') {
      try{
        sh 'docker rm -f simpleapp'
        sh 'docker rmi bathurudocker/simpleapp'       //sh 'docker rmi $(docker images bathurudocker/simpleapp)''
        }catch(error){
        //  do nothing if there is an exception
        }
        sh 'docker pull bathurudocker/simpleapp:${BUILD_NUMBER}'
        sh  'docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${VER_NUM}'
       }

  /*    stage('Deploy Into PROD') {
       sshagent(['docker_Server_SSH']) {
        sh "ssh -o StrictHostKeyChecking=no ec2-user@52.66.240.70  sudo docker rm -f simpleapp || true"
        sh "ssh -o StrictHostKeyChecking=no ec2-user@52.66.240.70  sudo docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${VER_NUM}"
     }
     }*/
}
