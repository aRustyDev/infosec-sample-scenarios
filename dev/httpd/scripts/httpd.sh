#!/bin/bash
rm /var/www/html/index.html
cp -r /opt/DVWA/* /var/www/html/
cd /var/www/html && cp config/config.inc.php.dist config/config.inc.php
chmod 757 /var/www/html/hackable/uploads/
chmod 646 /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt 
chmod 757 /var/www/html/config
sed -i 's/allow_url_include = Off/allow_url_include = On/' /etc/php/7.*/apache2/php.ini
sed -i "s/$_DVWA[ \'recaptcha_public_key\' ]  = \'\';/$_DVWA[ \'recaptcha_public_key\' ]  = \'6LdBxpcdAAAAAAlfIS5z6QjgTV2e0e_xh-sEW4Ql\';/" /etc/php/7.*/apache2/php.ini
sed -i "s/$_DVWA[ \'recaptcha_private_key\' ]  = \'\';/$_DVWA[ \'recaptcha_private_key\' ] = \'6LdBxpcdAAAAAGUoKS-UB5ec1t5HT0i19bra4sQw\';/" /etc/php/7.*/apache2/php.ini