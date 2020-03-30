def version = SNAPSHOT-1.0.${BUILD_NUMBER; 
node{
    stage('Git Checkout') {
          git url: 'https://github.com/bathurugithub/simpleapp.git', branch: 'master'
    }

    stage('SonarQube Analysis') {
         def mavenHome =  tool name: 'Maven', type: 'maven'
         withSonarQubeEnv('SonarQubeServer') {
                 sh "${mavenHome}/bin/mvn sonar:sonar"
          }
     }

    stage(" Maven Build") {
          def mavenHome =  tool name: "Maven", type: "maven"
          sh "${mavenHome}/bin/mvn clean -Dver=${BUILD_NUMBER} package "
    }

    stage('Copy to Nexus Repo'){
                    nexusPublisher  nexusInstanceId: 'NexusRepoServer',
                   nexusRepositoryId: 'DevopsRepo',
                            packages: [[$class: 'MavenPackage',
                      mavenAssetList: [[classifier: '', extension: '', filePath: "${WORKSPACE}/target/simpleapp-SNAPSHOT-1.0.${BUILD_NUMBER}.war"]],
                     mavenCoordinate: [artifactId: 'simpleapp', groupId: 'com.apple', packaging: 'war', version: "SNAPSHOT-1.0.${BUILD_NUMBER}"]]]
   }

   stage('Build & Push Docker Image'){
           sh 'docker build -t bathurudocker/simpleapp:${BUILD_NUMBER} .'
           withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
                  sh "docker login -u bathurudocker -p ${dockerpwd}"
           }
           sh 'docker push bathurudocker/simpleapp:${BUILD_NUMBER}'
           sh 'docker rmi bathurudocker/simpleapp:${BUILD_NUMBER}'
   }

   /*stage('Deploy Into PROD') {
           sshagent(['docker_Server_SSH']) {
               sh "ssh -o StrictHostKeyChecking=no ec2-user@52.66.240.70  sudo docker rm -f simpleapp || true"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@52.66.240.70  sudo docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${BUILD_NUMBER}"
          }
     }*/

}
