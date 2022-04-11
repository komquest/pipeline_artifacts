# Created By: komquest
# Creation Date: 4/9/2022
# Purpose:  Dockerfile for webserver automation build

FROM httpd:2.4

# Copy over Certs
COPY ./server.crt /usr/local/apache2/conf/
COPY ./server.key /usr/local/apache2/conf/

# Copy over Default web page
COPY ./index.html /usr/local/apache2/htdocs/

# Copy config script
COPY ./config.sh /opt/

# Run config script
RUN chmod 755 /opt/config.sh
RUN /opt/config.sh

# Expose Ports
EXPOSE 80
EXPOSE 443

CMD ["httpd-foreground"]