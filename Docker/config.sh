#!/bin/sh
##############################################################################################################
# Created By: komquest
# Creation Date: 4/9/2022
# Purpose: This script will configure Dockerhub Apache Webserver (https://hub.docker.com/_/httpd) before it is commited as an image.
# Initial config will:
# 1. Move Default Http Dir
# 2. Move Default SSL cert Dir
# 3. Enable TLS and enforce TLS 1.2
# 4. Set Custom Listening port for webserver
# 5. Set Permissions for TLS Certs Dir
# 6. Implement STIGS (All STIGs from: https://www.stigviewer.com/stig/apache_server_2.4_unix_server/)
# 7. Cleanup and delete script from server 
# Requirments:
# 1. Dockerfile that uses "RUN" to execute this script with "FROM" of version 2.4 apache http from docker hub
##############################################################################################################

# File Operations
## Create custom apache cert dir "/etc/pki/tls/" and set permissions
mkdir -p /etc/pki/tls/
chmod 644 /etc/pki/tls/

## Create custom apache http dir "/var/www/html/devsecops_practical" and set permissions
mkdir -p /var/www/html/devsecops_practical/
chmod 755 /var/www/html/devsecops_practical/

## Move custom web page to new home
mv /usr/local/apache2/htdocs/index.html /var/www/html/devsecops_practical

## Move Certs to new home and set permissions
mv /usr/local/apache2/conf/*.key /etc/pki/tls/
chmod 700 /etc/pki/tls/*.key

mv /usr/local/apache2/conf/*.crt /etc/pki/tls/
chmod 755 /etc/pki/tls/*.crt

# Configure Apache Base

## Update Document Root
sed -i -e 's/\(DocumentRoot \)\(".*"\)/\1"\/var\/www\/html\/devsecops_practical\/"/' /usr/local/apache2/conf/httpd.conf
sed -i -e 's/\(<Directory \)\(".*"\)/\1"\/var\/www\/html\/devsecops_practical\/"/' /usr/local/apache2/conf/httpd.conf

## Disable port 80 Listen
sed -i -e 's/\(Listen \)/\#\1/' /usr/local/apache2/conf/httpd.conf

#Configure TLS/SSL

## Enable TLS/SSL
sed -i -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' /usr/local/apache2/conf/httpd.conf
sed -i -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' /usr/local/apache2/conf/httpd.conf
sed -i -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' /usr/local/apache2/conf/httpd.conf

## Update Cert and DocumentRoot location
sed -i -e 's/\(DocumentRoot \)\(".*"\)/\1"\/var\/www\/html\/devsecops_practical\/"/' /usr/local/apache2/conf/extra/httpd-ssl.conf
sed -i -e 's/\(SSLCertificateFile \)\(".*"\)/\1"\/etc\/pki\/tls\/server.crt"/' /usr/local/apache2/conf/extra/httpd-ssl.conf
sed -i -e 's/\(SSLCertificateKeyFile \)\(".*"\)/\1"\/etc\/pki\/tls\/server.key"/' /usr/local/apache2/conf/extra/httpd-ssl.conf

## Update Listening Port to custom (I picked 5555)
sed -i -e 's/443/5555/' /usr/local/apache2/conf/extra/httpd-ssl.conf

# STIG Implementation

## V-214253 (The Apache web server must generate a session ID using as much of the character set as possible to reduce the risk of brute force.)
sed -i -e 's/^#\(LoadModule .*mod_unique_id.so\)/\1/' /usr/local/apache2/conf/httpd.conf

## V-214269 (The Apache web server must remove all export ciphers to protect the confidentiality and integrity of transmitted information)
## Also forced mod_ssl to only use TLSv1.2 ciphers for added security
sed -i -e 's/\(SSLCipherSuite \)\(.*\)/\1HIGH:MEDIUM:!EXP:!SSLv3:!kRSA/' /usr/local/apache2/conf/extra/httpd-ssl.conf
sed -i -e 's/\(SSLProxyCipherSuite \)\(.*\)/\1HIGH:MEDIUM:!EXP:!SSLv3:!kRSA/' /usr/local/apache2/conf/extra/httpd-ssl.conf




# Cleanup
rm /opt/config.sh