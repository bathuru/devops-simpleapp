def   VER_NUM;
def   REL_NUM;
def   mavenHome;
node{
    stage('Init') {
        VER_NUM = "1.0.${BUILD_NUMBER}";
        REL_NUM = "1.0.${BUILD_NUMBER}.RELEASE";
        mavenHome =  tool name: "Maven Slave", type: "maven"
    }

    stage('Git Checkout') {
          git url: 'https://github.com/bathurugithub/simpleapp.git', branch: 'master'
    }

    stage("Maven Build") {
          sh "${mavenHome}/bin/mvn clean versions:set -Dver=${VER_NUM} package "
    }

   stage('Build & Push Docker Image'){
           sh "sudo docker build -t bathurudocker/simpleapp:${VER_NUM} ."
           sh "sudo docker build -t bathurudocker/simpleapp:latest ."
           withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
                  sh "sudo docker login -u bathurudocker -p ${dockerpwd}"
           }
           sh "sudo docker push bathurudocker/simpleapp:${VER_NUM}"
           sh "sudo docker rmi bathurudocker/simpleapp:${VER_NUM}"

           sh "sudo docker push bathurudocker/simpleapp:latest"
           sh "sudo docker rmi bathurudocker/simpleapp:latest"
   }

   stage('Deploy Into PROD') {
           sshagent(['Ansible_Server_SSH']) {
               sh "ssh -o StrictHostKeyChecking=no ec2-user@13.233.122.254  sudo ansible-playbook  simpleappdeploy.yml"
          }
     }
}
