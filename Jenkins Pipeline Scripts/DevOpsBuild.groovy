node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://bwoodhouse322@bitbucket.org/devops322/uniquesum.git'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'mvn'
   }
   stage('Build') {
      // Run the maven build
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
      }
   }
   stage('Results') {
     // junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }
   
    stage('Publish') {
     nexusArtifactUploader artifacts: [[artifactId: 'Spec', classifier: '', file: '/var/jenkins_home/workspace/DevOpsBuilds/target/Dice-Game-1.0-SNAPSHOT.jar', type: 'jar']], credentialsId: 'NexusAdmin', groupId: 'SpecOps', nexusUrl: 'ec2-34-250-175-227.eu-west-1.compute.amazonaws.com:50000/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'releases', version: env.BUILD_NUMBER

    } 
}