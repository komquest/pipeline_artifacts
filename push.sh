#!/bin/bash
##############################################################################################################
# Created By: komquest
# Creation Date: 4/10/2022
# Purpose: This Script will push freshly built image to dockerhub
##############################################################################################################

HTTPNAME=$1
USER=$2
AUTH=$3
LOG="/var/lib/jenkins/logs/webserver.log"
DATE=$(date -u +%Y%m%d-%H.%M.%S)

echo "<${DATE}><INFO>_Pushing Container ${HTTPNAME}" >> ${LOG} 2>&1

docker login -u "${USER}" -p "${AUTH}" >> ${LOG} 2>&1
docker push "${HTTPNAME}" >> ${LOG} 2>&1
docker logout >> ${LOG} 2>&1

if [ $? -ne 0 ]; then
  echo "<${DATE}><ERROR>_Please Verify Config ${HTTPNAME}" >> ${LOG} 2>&1
  exit 1
else
  echo "<${DATE}><INFO>_Push Successful ${HTTPNAME}" >> ${LOG} 2>&1
  exit 0
fi