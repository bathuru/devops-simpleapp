node{
    stage('Git Checkout') {
        git url: 'https://github.com/bathurugithub/panda.git', branch: 'master'
    }

    stage(" Maven Build") {
      def mavenHome =  tool name: "Maven", type: "maven"
      sh "${mavenHome}/bin/mvn clean package -Dbuild.number=${BUILD_NUMBER}"
    }

    stage('Build & Push Docker Image'){
      sh "Build & Push Docker Image'"
    }

    stage('Deploy Into PROD') {
      sh "echo Deploy Into PROD"
     }
}
