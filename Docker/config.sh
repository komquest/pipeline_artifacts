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
# 6. Implement STIGS
# 7. Cleanup and delete itself from server 
# Requirments:
# 1. Dockerfile that uses "RUN" to execute this script and version 2.4 of apache http from docker hub

# Note all this execution happens before apache is started
##############################################################################################################

#File Operations
## Create custom apache cert dir "/etc/pki/tls/" and set permissions
mkdir /etc/pki/tls/
chmod 644 /etc/pki/tls/

##Create custom apache http dir "/var/www/html/devsecops_practical" and set permissions
mkdir /var/www/html/devsecops_practical/
chmod 755 /var/www/html/devsecops_practical/

##Move custom web page to new home
mv /usr/local/apache2/htdocs/index.html /var/www/html/devsecops_practical

##Move Certs to new home and set permissions
mv /usr/local/apache2/conf/*.key /etc/pki/tls/
chmod 700 /etc/pki/tls/*.key

mv /usr/local/apache2/conf/*.crt /etc/pki/tls/
chmod 755 /etc/pki/tls/*.crt

#Configure Apache Base

## Update Document Root
sed -i -e 's/\(DocumentRoot \)\(".*"\)/\1"\/var\/www\/html\/devsecops_practical\/"/' /usr/local/apache2/conf/httpd.conf
sed -i -e 's/\(<Directory \)\(".*"\)/\1"\/var\/www\/html\/devsecops_practical\/"/' /usr/local/apache2/conf/httpd.conf

## Update Listening Port Number


#Enable and config TLS/SSL

## Enable TLS/SSL
sed -i -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' /usr/local/apache2/conf/httpd.conf
sed -i -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' /usr/local/apache2/conf/httpd.conf
sed -i -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' /usr/local/apache2/conf/httpd.conf

## Update Cert and DocumentRoot location
sed -i -e 's/\(DocumentRoot \)\(".*"\)/\1"\/var\/www\/html\/devsecops_practical\/"/' /usr/local/apache2/conf/extra/httpd-ssl.conf
sed -i -e 's/\(SSLCertificateFile \)\(".*"\)/\1"\/etc\/pki\/tls\/server.crt"/' /usr/local/apache2/conf/extra/httpd-ssl.conf
sed -i -e 's/\(SSLCertificateKeyFile \)\(".*"\)/\1"\/etc\/pki\/tls\/server.key"/' /usr/local/apache2/conf/extra/httpd-ssl.conf

# Cleanup
rm /opt/config.sh