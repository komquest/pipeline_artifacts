FROM httpd:2.4
#COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./dev.crt /usr/local/apache2/conf/
COPY ./dev.key /usr/local/apache2/conf/

RUN sed -i \
        -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
        -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
        -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
        conf/httpd.conf

EXPOSE 80
EXPOSE 443

CMD ["httpd-foreground"]