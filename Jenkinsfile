node{
    stage('SCM Checkout') {
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

      stage('Deploy Into Dev Server') {
      try{
        sh 'docker rm -f simpleapp'
        sh 'docker rmi bathurudocker/simpleapp:${BUILD_NUMBER}'
        }catch(error){
        //  do nothing if there is an exception
        }
        sh 'docker pull bathurudocker/simpleapp:${BUILD_NUMBER}'
        sh  'docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${BUILD_NUMBER}'
       }
}
