#!/bin/bash
service apache2 start
sudo tcpdump -i eth0 -C 25 -w dvwa &
wait -n