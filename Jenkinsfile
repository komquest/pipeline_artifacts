// Created By: komquest
// Creation Date: 4/10/2022
// Purpose:  Jenkinsfile for webserver automation build

pipeline {

  agent any

  environment {

    //Variables and make scripts executable
    SERVERNAME = sh(script: "chmod +x *.sh;./id.sh", returnStdout: true).trim()
    HOSTPORT = "443"
    DOCKERPORT = "5555"

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
          sh("./run.sh ${SERVERNAME} ${HOSTPORT} ${DOCKERPORT}")

        }
      }

      stage('TEST') {

        steps {
          
          echo 'Testing Container'
          sh("./test.sh ${SERVERNAME} ${HOSTPORT} ${DOCKERPORT}")

        }
      }

      stage('STOP') {

        steps {
          
          echo 'Stopping Container'
          sh("./stop.sh ${SERVERNAME} ${HOSTPORT} ${DOCKERPORT}")

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
