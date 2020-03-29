node{
    stage('Git Checkout') {
        git url: 'https://github.com/bathurugithub/panda.git', branch: 'master'
    }

    stage(" Maven Build") {
      def mavenHome =  tool name: "Maven", type: "maven"
      sh "${mavenHome}/bin/mvn clean -Dversion=${BUILD_NUMBER} package "
    }

    stage('Copy to Nexux Repo'){
    nexusPublisher   nexusInstanceId: 'NexusRepoServer',
                   nexusRepositoryId: 'DevopsNexusRepo',
                            packages: [[$class: 'MavenPackage',
                      mavenAssetList: [[classifier: '', extension: '', filePath: '/Users/srinivas/.jenkins/workspace/portal/target/simpleapp-SNAPSHOT-1.0.${BUILD_NUMBER}.war']],
                     mavenCoordinate: [artifactId: 'simpleapp', groupId: 'com.mt', packaging: 'war', version: '1.0']]]
   }
}
