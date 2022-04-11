#!/bin/bash
##############################################################################################################
# Created By: komquest
# Creation Date: 4/10/2022
# Purpose: This Script will Create a Unique Server ID that can be fed into Jenkins and Docker as to keep track 
# of new server
##############################################################################################################

ID=$(hexdump -n 4 -e '4/4 "%04X" 1 "\n"' /dev/urandom)
HTTPNAME="komquest/webserver:${ID}"

LOG="/var/lib/jenkins/logs/webserver.log"
DATE=$(date -u +%Y%m%d-%H.%M.%S)

if [ $? -ne 0 ]; then
  echo "<${DATE}><ERROR>_UNABLE_TO_CREATE_ID ${HTTPNAME}" >> ${LOG} 2>&1
  exit 1
else
  echo "<${DATE}><INFO>_START_CREATED_ID ${HTTPNAME}" >> ${LOG} 2>&1
  echo $HTTPNAME
  exit 0
fi