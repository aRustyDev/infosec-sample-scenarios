#!/bin/bash
cd /usr/local/apache2/htdocs && cp config/config.inc.php.dist config/config.inc.php
chmod 757 /usr/local/apache2/htdocs/hackable/uploads/
chmod 646 /usr/local/apache2/htdocs/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt 
chmod 757 /usr/local/apache2/htdocs/config
sed -i 's/allow_url_include = Off/allow_url_include = On/' /etc/php/7.4/apache2/php.ini
sed -i "s/$_DVWA[ \'recaptcha_public_key\' ]  = \'\';/$_DVWA[ \'recaptcha_public_key\' ]  = \'6LdBxpcdAAAAAAlfIS5z6QjgTV2e0e_xh-sEW4Ql\';/" /etc/php/7.4/apache2/php.ini
sed -i "s/$_DVWA[ \'recaptcha_private_key\' ]  = \'\';/$_DVWA[ \'recaptcha_private_key\' ] = \'6LdBxpcdAAAAAGUoKS-UB5ec1t5HT0i19bra4sQw\';/" /etc/php/7.4/apache2/php.ini