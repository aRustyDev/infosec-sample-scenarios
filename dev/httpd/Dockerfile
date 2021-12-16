FROM httpd
COPY ./src/dvwa/* /opt/dvwa
COPY ./scripts/httpd.sh /opt/scripts/httpd.sh
RUN chmod 744 /opt/scripts/httpd.sh && /opt/scripts/httpd.sh
# EXPOSE 80