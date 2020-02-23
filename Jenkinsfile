pipeline {
	agent { label 'test' }

	stages
	{
	 stage('Checkout')
	 {
	  steps {
	    git branch: 'master', url: 'https://github.com/techylinux/site-maven.git'
	  }
	 }
	  stage('Build war')
	  {
	   steps {
	     sh "mvn clean package"
	   }
	  }

	   stage ('Build image')
	    {
	      steps {
	       script {
	          docker.withRegistry( 'https://registry.hub.docker.com', 'dockerp'){
	           /* Build docker images locally */
	           myImage = docker.build("smtksumit/devops:v1")

	           /* push the images to the Registry */
	            myImage.push()
	          }
	       }
	      }
	    }
	   stage('Upload artifactory')
	   {
         steps {
          script {
                  /* Define the artifactory server details */
               def server = Artifactory.server 'artifact_demo'
               def uploadSpec = """{
                   "files": [{
                   "pattern": "target/*.war",
                   "target": "Demo"
                   }]
               }"""
             
               /* Uplaod the war to Artifacts repo */
                  server.upload(uploadSpec)
          }

         }

	   }
	   stage('Sonar qube analysis')
	   {
	    steps {
         withSonarQubeEnv('sonar-code'){
          sh 'mvn sonar:sonar'
         }
	    }
	   }

	}
}
