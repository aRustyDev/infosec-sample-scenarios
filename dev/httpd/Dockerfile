FROM httpd as build
RUN apt update && apt upgrade -y

FROM build as apache2
COPY ./src/DVWA/ /opt/dvwa/
COPY ./scripts/httpd.sh /opt/scripts/httpd.sh
RUN chmod 744 /opt/scripts/httpd.sh && /opt/scripts/httpd.sh
# EXPOSE 80