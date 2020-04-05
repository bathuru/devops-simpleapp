pipeline {
    agent {
          label 'master'
     }
    triggers {
          pollSCM('0 */4 * * 1-5')
    }
    environment {
          VER_NUM = "1.0.${BUILD_NUMBER}";
          REL_NUM = "1.0.${BUILD_NUMBER}.RELEASE";
          mavenHome =  tool name: "Maven Master", type: "maven"
     }
    tools{
          maven 'Maven Master'
     }
    stages {
         stage('Git Checkout') {
              when {
                   branch 'master'
              }
              steps {
                     echo pwd;
                     git url: 'https://github.com/bathurugithub/simpleapp.git',  branch: 'master'
              }
         }
         stage("Maven Build") {
             steps {
                    sh "${mavenHome}/bin/mvn clean versions:set -Dver=${VER_NUM} package "
              }
         }
     }
}
