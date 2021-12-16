FROM httpd as build
RUN apt update && apt upgrade -y

FROM build as apache2
RUN rm /usr/local/apache2/htdocs/index.html
COPY ./src/DVWA/ /usr/local/apache2/htdocs/
COPY ./scripts/httpd.sh /opt/scripts/httpd.sh
RUN chmod 744 /opt/scripts/httpd.sh && /opt/scripts/httpd.sh
# EXPOSE 80