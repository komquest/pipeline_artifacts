// Created By: komquest
// Creation Date: 4/10/2022
// Purpose:  Jenkinsfile for webserver automation build

pipeline {

  agent any

  environment {

    //Variables
    SERVERNAME = sh(returnStdout: true, script: "./id.sh")
    BUILD = "0"
    RUN = "0"
    TEST = "0"

    //Make all scripts excutable
    //sh(script: "chmod +x *.sh")

  }

  stages {

      
      stage('Build') {

        steps {
          
          echo 'Building Image'
          //BUILD = sh(returnStdout: true, script: "build.sh ${SERVERNAME}").trim()

        }
      }

      stage('Run') {
        
        when {

          expression {

            BUILD == "0" && RUN == "0" && TEST == "0"

          }

        }
        steps {
          
          echo 'Running Image'
          //sh "docker run -dit --name -p 443:5555 webserver:"

        }
      }

      stage('TEST') {
        
        when {

          expression {

            BUILD == "0" && RUN == "0" && TEST == "0"

          }

        }
        steps {
          
          echo 'Testing Container'
          //sh "docker run -dit --name -p 443:5555 webserver:"

        }
      }

      stage('PUSH') {
        
        when {

          expression {

            BUILD == "0" && RUN == "0" && TEST == "0"

          }

        }
        steps {
          
          echo 'Pushing Image'
          //sh "docker run -dit --name -p 443:5555 webserver:"

        }
      }

      stage('ERROROUT') {

        steps {

          echo "BUILD: ${BUILD}"
          echo "RUN: ${RUN}"
          echo "TEST: ${TEST}"

        }


      }


  }


}
