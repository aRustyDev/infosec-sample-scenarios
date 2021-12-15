FROM httpd
COPY src/dvwa/* /opt/dvwa
COPY ./scripts/httpd.sh /httpd.sh
RUN chmod 744 /scripts/httpd.sh && /scripts/httpd.sh
# EXPOSE 80