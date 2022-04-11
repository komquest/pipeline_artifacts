#!/bin/bash
##############################################################################################################
# Created By: komquest
# Creation Date: 4/10/2022
# Purpose: This Script will stop the container after test so ports are unbinded and resources are managed
##############################################################################################################

HTTPNAME=$1
HOSTPORT=$2
DOCKERPORT=$3
LOG="/var/lib/jenkins/logs/webserver.log"
DATE=$(date -u +%Y%m%d-%H.%M.%S)

echo "<${DATE}><INFO>_Stopping Container ${HTTPNAME}" >> ${LOG} 2>&1

docker stop $(docker ps | grep "${HTTPNAME}"| tr -s ' ' | cut -d ' ' -f 1)

if [ $? -ne 0 ]; then
  echo "<${DATE}><ERROR>_Please Verify Config ${HTTPNAME}" >> ${LOG} 2>&1
  exit 1
else
  echo "<${DATE}><INFO>_STOPPED ${HTTPNAME}" >> ${LOG} 2>&1
  exit 0
fi