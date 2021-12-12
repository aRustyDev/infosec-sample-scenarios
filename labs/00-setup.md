# Setup Kali
```
apt-get install -y \
    burpsuite \
    firefox-esr \
    gedit \
    hydra \
    hashcat \
    iproute2 \
    john \
    metasploit-framework \
    nano \
    netcat-openbsd \
    nmap \
    sqlmap \
    vim \
    wireshark \ 
    docker.io \ 
    docker-compose
```

```
echo localhost examplecorp.com >> /etc/hosts
```


# docker pull ubuntu
# download DVWA
```
apt update && apt upgrade
apt install -y apache2 mysql-server php php-mysqli php-gd libapache2-mod-php git tcpdump vim iproute2 
cd ~ 
git clone https://github.com/digininja/DVWA.git
rm /var/www/html/index.html
cp -r ~/DVWA/* /var/www/html/
cd /var/www/html
cp config/config.inc.php.dist config/config.inc.php
chmod 757 /var/www/html/hackable/uploads/
chmod 646 /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt 
chmod 757 /var/www/html/config

sed s/allow_url_include = Off/allow_url_include = On/ /etc/php/7.*/apache2/php.ini

systemctl restart apache2
service apache2 restart

tcpdump -i eth0 -w <pcapfile> &
```








# sources 
https://danielmiessler.com/study/tcpdump/