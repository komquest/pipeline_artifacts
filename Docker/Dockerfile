FROM httpd:2.4
#COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf

# Copy over Certs
COPY ./server.crt /usr/local/apache2/conf/
COPY ./server.key /usr/local/apache2/conf/

# Copy over Default web page
COPY ./index.html /usr/local/apache2/htdocs/

# Copy config script
COPY ./config.sh /opt/

# This will enable ssl
#RUN sed -i \
#        -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
#        -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
#        -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
#        /usr/local/apache2/conf/httpd.conf

# Run Config Script to Commit to Image
# RUN chmod +x /opt/config.sh
# RUN /opt/config.sh
CMD chomd 755 /opt/config.sh && /opt/config.sh


# Expose Ports
EXPOSE 80
EXPOSE 443

CMD ["httpd-foreground"]