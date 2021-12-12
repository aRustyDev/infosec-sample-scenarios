#!/bin/bash
service apache2 start
service mysql start
sudo tcpdump -i eth0 -C 25 -w dvwa &
wait -n