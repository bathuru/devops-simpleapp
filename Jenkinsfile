pipeline {
    agent {
          label 'jenkins-slave-1'
     }
    triggers {
          pollSCM('4 4 4 * *')
    }
    environment {
          VER_NUM = "1.0.${BUILD_NUMBER}";
          REL_NUM = "1.0.${BUILD_NUMBER}.RELEASE";
          mavenHome =  tool name: "devops-maven", type: "maven"
     }
    tools{
          maven 'devops-maven'
     }
    stages {
           stage ('Git Checkout') {
                 steps {
                     echo pwd;
                     git credentialsId: 'github-credentials' , url: 'https://github.com/bathurugithub/simpleapp.git',  branch: 'master'   
                }
           }

         stage ('Multiple Builds') {
              parallel {
                  stage ("Maven Build") {
                        steps {
                             echo pwd;
                            sh "${mavenHome}/bin/mvn clean versions:set -Dver=${VER_NUM} package "
                       }
                  }
                  stage ("Gradel Build") {
                        steps {
                            echo "Gradel Build !!!!!!!"
                       }
                  }
              }
          }

         stage ('Upload to Nexus') {
                  steps {
                          echo pwd;
                           nexusPublisher  nexusInstanceId: 'AppleNexusRepo',
                           nexusRepositoryId: 'simpleappRepo',
                           packages: [[$class: 'MavenPackage',
                           mavenAssetList: [[classifier: '', extension: '', filePath: "${WORKSPACE}/target/simpleapp-${REL_NUM}.war"]],
                           mavenCoordinate: [artifactId: 'simpleapp', groupId: 'com.apple', packaging: 'war', version: "${REL_NUM}"]]]
                   }
          }

          stage('Build & Push Docker Image') {    
                  steps {
                          script{        // To add Scripted Pipeline sentences into a Declarative
                                    try{
                                             sh "docker rm -f simpleapp || true"
                                             sh "docker rmi bathurudocker/simpleapp || true"       //sh 'docker rmi $(docker images bathurudocker/simpleapp)''
                                          }catch(error){
                                          //  do nothing if there is an exception
                                          }
                            }
                          sh "docker build -t bathurudocker/simpleapp:${VER_NUM} ."
                 } 
          }
          /*
        stage('SonarQube Analysis') {
             steps {
                    withSonarQubeEnv('SonarQubeServer') {
                        sh "${mavenHome}/bin/mvn sonar:sonar"
                     }
             }
         }*/

          /*
          stage('Build & Push Docker Image') {    
                  steps {
                          script{        // To add Scripted Pipeline sentences into a Declarative
                                    try{
                                             sh "docker rm -f simpleapp || true"
                                             sh "docker rmi bathurudocker/simpleapp || true"       //sh 'docker rmi $(docker images bathurudocker/simpleapp)''
                                          }catch(error){
                                          //  do nothing if there is an exception
                                          }
                            }
                          sh "docker build -t bathurudocker/simpleapp:${VER_NUM} ."
                          /*withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
                                 sh "docker login -u bathurudocker -p ${dockerpwd}"
                         }
                          sh "docker push bathurudocker/simpleapp:${VER_NUM}" */
                          //sh  "docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${VER_NUM}"
                 //} 
          //}
    }
    post {
           success {
                echo 'Pipeline finished'
           }
           failure {
                echo 'Pipeline failure'
           }
    }
}
