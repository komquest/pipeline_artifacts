FROM httpd:2.4
#COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf

# Copy over Certs
COPY ./server.crt /usr/local/apache2/conf/
COPY ./server.key /usr/local/apache2/conf/

# Copy over Default web page
COPY ./index.html /usr/local/apache2/htdocs/

# Copy config script
COPY ./config.sh /opt/

RUN chmod 755 /opt/config.sh
RUN /opt/config.sh

# Expose Ports
EXPOSE 80
EXPOSE 443

CMD ["httpd-foreground"]