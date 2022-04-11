#!/bin/bash
##############################################################################################################
# Created By: komquest
# Creation Date: 4/10/2022
# Purpose: This Script will test the started webserver container to make sure:
# 1. It returns a http 1.1 200 status
# 2. The cert matches the cert file that was copied to the webserver
#
# It will accomplish this by using curl to check status and openssl to verify/download cert and it will compare
##############################################################################################################

HTTPNAME=$1
HOSTPORT=$2
DOCKERPORT=$3
LOG="/var/lib/jenkins/logs/webserver.log"
DATE=$(date -u +%Y%m%d-%H.%M.%S)

# Code to look for
HTTPSTATUS = "HTTP/1.1 200 OK"

# SSL Vars
DOWNCERT = ""
FILECERT = ""

echo "<${DATE}><INFO>_Start HTTP TEST ${HTTPNAME}" >> ${LOG} 2>&1

# Check For Status Code Match
WEBCHECK = $(curl -sI -k "https://127.0.0.1:${HOSTPORT}" | head -1 | grep "${HTTPSTATUS}")

if [ -z $WEBCHECK ]; then

  echo "<${DATE}><ERROR>_STATUS_CHECK_FAILED ${HTTPNAME}" >> ${LOG} 2>&1
  exit 1

else

  echo "<${DATE}><INFO>_STATUS_CHECK_PASSED ${HTTPNAME}" >> ${LOG} 2>&1

fi

# Verify SSL
#Grab SSL/TLS Cert hash
DOWNCERT = ($(openssl s_client -connect "127.0.0.1:${HOSTPORT}" 2>/dev/null </dev/null |  sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | sha256sum))
FILECERT = ($(cat ./*.crt | sha256sum))

if [ "$DOWNCERT" -n "$FILECERT"]; then

  echo "<${DATE}><ERROR>_CERT_CHECK_FAILED ${HTTPNAME}" >> ${LOG} 2>&1
  exit 1

else

  echo "<${DATE}><INFO>_CERT_CHECK_PASSED ${HTTPNAME}" >> ${LOG} 2>&1

fi


if [ $? -ne 0 ]; then
  echo "<${DATE}><ERROR>_Please Verify Config ${HTTPNAME}" >> ${LOG} 2>&1
  exit 1
else
  echo "<${DATE}><INFO>_TEST_SUCCESSFUL ${HTTPNAME}" >> ${LOG} 2>&1
  exit 0
fi