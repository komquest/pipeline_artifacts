# README
## Purpose: This project takes a simple apache httpd server from dockerhub, does basic customizations, rebuilds as custom image, and then pushes to dockerhub with Jenkins.

---

## Goals:
1. To learn more about Docker, Jenkins and how to integrate them
2. To learn more about pipeline automation (CI/CD)
3. To learn more about how a DevOps shop functions
4. To have fun

---


## Requirements:

1. Github Repo with this project
2. Docker and Jenkins installed and running on Linux
3. Jenkins plugins: `Github(all installed by default), Docker Pipeline (for dockerhub creds)`
4. Dockerhub account


## Setup:

1. Change part of `HTTPNAME` in [id.sh](./id.sh) to your respective dockerhub account name (and other modifications as you see fit).
2. Build a Multibranch Pipe in Jenkins pointing to a repo that hosts a clone of this project (make sure you have the creds for both github (Personal Access Token) and dockerhub)
3. Jenkins will download the Jenkinsfile and build, configure and deploy

## The Mostly Detailed Process:

- Jenkins polls Github, if the repo has changed, it will download
- After Download Jenkins will run its Stages, with first generating a "SERVERNAME" that will act as a unqiue identifier.
- BUILD STAGE: Applies custom configs to httpd (https://hub.docker.com/_/httpd) that do minimal things like change the default listening port, enable ssl/tls, change default dirs/index.html, generates self-signed X509 cert, and more. After configuration it builds as docker image
- RUN STAGE: This will run the image as a container, enough said
- TEST STAGE: This will test the webserver to verify it works. It will only do simple tests:
  - Verify the server is reachable on its listening port (checks for http 200)
  - Verifies the cert is the same as the one that was copied to the server during the build stage 
- STOP STAGE: Stops the container so it doesn't inhibt the build/run stage for other jobs
- PUSH STAGE: Pushes to dockerhub, thus completing the pipeline

## Some Tech Details:
- Log files by default saved to `/var/lib/jenkins/logs/webserver.log`
- Tags aren't really done correctly for docker images, instead of being a progressive version number all tags are a random hex string
- The whole backbone of this project is done in bash due to its simplicity. If this thing was more complicated I probably would have used Python
- Take a look at [config.sh](./config.sh) if you would like to see all the changes made to the webserver from the default

---



