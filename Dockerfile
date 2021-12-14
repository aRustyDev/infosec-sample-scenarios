FROM ubuntu as build

RUN apt update && apt upgrade -y
RUN export DEBIAN_FRONTEND='noninteractive' && apt install -y apache2\
    mysql-server \
    php \
    php-mysqli \
    php-gd \
    libapache2-mod-php \
    git \
    tcpdump \
    systemctl

FROM build as config
RUN cd ~ && git clone https://github.com/digininja/DVWA.git
RUN rm /var/www/html/index.html
RUN cp -r ~/DVWA/* /var/www/html/
RUN cd /var/www/html && cp config/config.inc.php.dist config/config.inc.php
RUN chmod 757 /var/www/html/hackable/uploads/
RUN chmod 646 /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt 
RUN chmod 757 /var/www/html/config
RUN sed -i 's/allow_url_include = Off/allow_url_include = On/' /etc/php/7.*/apache2/php.ini
RUN sed -i "s/$_DVWA[ \'recaptcha_public_key\' ]  = \'\';/$_DVWA[ \'recaptcha_public_key\' ]  = \'6LdBxpcdAAAAAAlfIS5z6QjgTV2e0e_xh-sEW4Ql\';/" /etc/php/7.*/apache2/php.ini
RUN sed -i "s/$_DVWA[ \'recaptcha_private_key\' ]  = \'\';/$_DVWA[ \'recaptcha_private_key\' ] = \'6LdBxpcdAAAAAGUoKS-UB5ec1t5HT0i19bra4sQw\';/" /etc/php/7.*/apache2/php.ini

FROM config
COPY ./scripts /scripts
RUN chmod 744 /scripts/*
RUN systemctl enable apache2 && systemctl enable mysql
RUN /scripts/setup-mysql.sh
EXPOSE 80
CMD tcpdump -i eth0 -C 25 -w /var/log/pcap/dvwa & 
# ENTRYPOINT ["/entrypoint.sh"]