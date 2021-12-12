#!/bin/bash
CONTAINER="target-dvwa"
sudo docker build -t $CONTAINER .
sudo docker run -it --rm -v volumes:/var/log/pcap -p 80:80 $(sudo docker images | grep $CONTAINER | awk '{print $3}')