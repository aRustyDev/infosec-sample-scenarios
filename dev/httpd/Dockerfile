FROM httpd as build
RUN apt update && apt upgrade -y

FROM build as apache2
COPY ./src/DVWA/ /opt/dvwa/
COPY ./scripts/httpd.sh /opt/scripts/httpd.sh
RUN rm /usr/local/apache2/htdocs/index.html
RUN cp -r /opt/dvwa/* /usr/local/apache2/htdocs/
RUN chmod 744 /opt/scripts/httpd.sh && /opt/scripts/httpd.sh
# EXPOSE 80