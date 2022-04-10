##############################################################################################################
# Created By: komquest
# Creation Date: 4/9/2022
# Purpose: This Script will start the automation process to build, configure and STIG an httpd docker image.
# In particular this will build the x509 certs, and start the build process for the docker image.
# Each Docker Image will be given a unqiue id based off of a random string
# Requirments:
# 1. Dockerfile for apache build must be in root dir
# 2. All files for Dockerfile copy must be in root dir
# 3. openssl installed
# 4. Docker installed and running
# 5. Active Internet connection

# This script will not take any agruments at this time, but can change based off of requirments
##############################################################################################################

#!/bin/bash

#Get Random ID and Name

ID=$(hexdump -n 4 -e '4/4 "%04X" 1 "\n"' /dev/urandom)
HTTPNAME="webserver:${ID}"

#Build X509 Certs

openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj "/C=HW/ST=Hello/L=World/O=HelloWorld/CN=www.helloworld.com" -keyout server.key -out server.crt

#Build Docker Image (See Dockerfile for more information)

docker build ./ -t $HTTPNAME

#Display Build, with simple error checking

if [ $? -ne 0 ]; then
  echo "<ERROR>_Please Verify Config"
else
  echo "<INFO>_Built ${HTTPNAME}"
fi





