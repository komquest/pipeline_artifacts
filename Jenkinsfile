// Created By: komquest
// Creation Date: 4/10/2022
// Purpose:  Jenkinsfile for webserver automation build

pipeline {

  agent any
    
  //Make all scripts excutable
  sh("chmod +x *.sh")

  environment {

    //Variables
    SERVERNAME = sh("./id.sh")

  }

  stages {

      
      stage('Build') {

        steps {
          
          echo 'Building Image'
          //BUILD = sh(returnStdout: true, script: "build.sh ${SERVERNAME}").trim()

        }
      }

      stage('Run') {
        
        steps {
          
          echo 'Running Image'
          //sh "docker run -dit --name -p 443:5555 webserver:"

        }
      }

      stage('TEST') {

        steps {
          
          echo 'Testing Container'
          //sh "docker run -dit --name -p 443:5555 webserver:"

        }
      }

      stage('PUSH') {
        
        steps {
          
          echo 'Pushing Image'
          //sh "docker run -dit --name -p 443:5555 webserver:"

        }
      }


  }


}
