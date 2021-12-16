FROM httpd as build
RUN apt update && apt upgrade -y
RUN apt install -y git php php-mysqli php-gd libapache2-mod-php

FROM build as apache2
RUN rm /usr/local/apache2/htdocs/index.html
RUN cd /opt && git clone https://github.com/digininja/DVWA.git
RUN cp -r /opt/DVWA/* /usr/local/apache2/htdocs/
COPY ./scripts/httpd.sh /opt/scripts/httpd.sh
RUN chmod 744 /opt/scripts/httpd.sh && /opt/scripts/httpd.sh
# EXPOSE 80