node{

    stage('Git Checkout') {
        git url: 'https://github.com/bathurugithub/panda.git', branch: 'master'
    }

    stage(" Maven Build") {
      def mavenHome =  tool name: "Maven", type: "maven"
      sh "${mavenHome}/bin/mvn clean -Dver=${BUILD_NUMBER} package "
    }

    stage('SonarQube Analysis') {
         def mavenHome =  tool name: 'Maven', type: 'maven'
         withSonarQubeEnv('SonarQubeServer') {
                 sh "${mavenHome}/bin/mvn sonar:sonar"
          }
     }

    stage('Copy to Nexus Repo'){
                    nexusPublisher  nexusInstanceId: 'NexusRepoServer',
                   nexusRepositoryId: 'DevopsNexusRepo',
                            packages: [[$class: 'MavenPackage',
                      mavenAssetList: [[classifier: '', extension: '', filePath: "${WORKSPACE}/target/simpleapp-SNAPSHOT-1.0.${BUILD_NUMBER}.war"]],
                     mavenCoordinate: [artifactId: 'simpleapp', groupId: 'com.mt', packaging: 'war', version: "SNAPSHOT-1.0.${BUILD_NUMBER}"]]]
   }
}
