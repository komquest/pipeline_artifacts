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
    DOCKERHUB = credentials('dockerhub')

  }

  stages {

      
      stage('BUILD') {

        steps {
          
          echo 'Building Image'
          sh("./build.sh ${SERVERNAME}")

        }
      }

      stage('RUN') {
        
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
          sh("./push.sh ${SERVERNAME} ${dockerhub_USR} ${dockerhub_PSW}")


        }
      }


  }


}
