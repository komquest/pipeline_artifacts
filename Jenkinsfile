// Created By: komquest
// Creation Date: 4/10/2022
// Purpose:  Jenkinsfile for webserver automation build

pipeline {

  agent any

  environment {

    //Variables and make scripts executable
    SERVERNAME = sh(script: "chmod +x *.sh;./id.sh", returnStdout: true)

  }

  stages {

      
      stage('Build') {

        steps {
          
          echo 'Building Image'
          sh("./build.sh ${SERVERNAME}")

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
