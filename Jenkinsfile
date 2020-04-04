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
          sh "pwd"
          git url: 'https://github.com/bathurugithub/simpleapp.git', branch: 'master'
    }

    stage("Maven Build") {
          sh "pwd"
          sh "${mavenHome}/bin/mvn clean versions:set -Dver=${VER_NUM} package "
    }

   stage('Build & Push Docker Image'){
           sh "pwd"
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
           sh "pwd"
           sshagent(['Ansible-Server-SSH']) {
               sh "scp -o StrictHostKeyChecking=no simpleapp-deploy-k8s.yaml simpleapp-playbook-k8s.yml ec2-user@13.232.221.131:/home/ec2-user/"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@13.232.221.131 ansible-playbook  -i /etc/ansible/hosts /home/ec2-user/simpleapp-playbook-k8s.yml"
          }
     }
}
