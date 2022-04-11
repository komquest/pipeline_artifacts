#!/bin/bash
##############################################################################################################
# Created By: komquest
# Creation Date: 4/10/2022
# Purpose: This Script will run the newly created docker image, setup for testing script
##############################################################################################################

HTTPNAME=$1
HOSTPORT=$2
DOCKERPORT=$3
LOG="/var/lib/jenkins/logs/webserver.log"
DATE=$(date -u +%Y%m%d-%H.%M.%S)

echo "<${DATE}><INFO>_Start Run ${HTTPNAME}" >> ${LOG} 2>&1

docker run -dit -p ${HOSTPORT}:${DOCKERPORT} ${HTTPNAME} >> ${LOG} 2>&1

if [ $? -ne 0 ]; then
  echo "<${DATE}><ERROR>_Please Verify Config ${HTTPNAME}" >> ${LOG} 2>&1
else
  echo "<${DATE}><INFO>_RUNNING ${HTTPNAME}" >> ${LOG} 2>&1
fi