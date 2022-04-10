#!/bin/sh
##############################################################################################################
# Created By: komquest
# Creation Date: 4/9/2022
# Purpose: This script will configure Dockerhub Apache Webserver (https://hub.docker.com/_/httpd) before it is commited as an image.
# Initial conif will:
# 1. Move Default Http Dir
# 2. Move Default SSL cert Dir
# 3. Enable TLS and enforce TLS 1.2
# 4. Set Custom Listening port for webserver
# 5. Set Permissions for TLS Certs folder
# 6. Cleanup and delete itself from server 
# Requirments:
# 1. Dockerfile that uses "RUN" to execute this script and version 2.4 of apache http from docker hub

# Note all this execution happens before apache is started
##############################################################################################################


# Enable SSL
sed -i -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' /usr/local/apache2/conf/httpd.conf


# Cleanup
rm /opt/config.sh