FROM ubuntu as build

RUN apt update && apt upgrade
RUN export DEBIAN_FRONTEND='noninteractive' && apt install -y apache2\
    mysql-server \
    php \
    php-mysqli \
    php-gd \
    libapache2-mod-php \
    git \
    tcpdump

FROM build as config
RUN cd ~ && git clone https://github.com/digininja/DVWA.git
RUN rm /var/www/html/index.html
RUN cp -r ~/DVWA/* /var/www/html/
RUN cd /var/www/html && cp config/config.inc.php.dist config/config.inc.php
RUN chmod 757 /var/www/html/hackable/uploads/
RUN chmod 646 /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt 
RUN chmod 757 /var/www/html/config
RUN sed 's/allow_url_include = Off/allow_url_include = On/' /etc/php/7.*/apache2/php.ini
RUN echo localhost examplecorp.com >> /etc/hosts
RUN service apache2 restart

FROM config
COPY ./scripts/entrypoint.sh /entrypoint.sh
RUN chmod 744 entrypoint.sh
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]