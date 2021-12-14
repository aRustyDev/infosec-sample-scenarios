# Setup Kali
```bash
apt install -y \
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
    docker.io 

echo <ipaddr> examplecorp.com >> /etc/hosts
mkdir ~/repos && cd ~/repos && git clone https://github.com/aRustyDev/infosec-sample-scenarios.git
```
# Start Target Container
```bash
docker pull ubuntu
docker build -t target-dvwa .

export CONTAINER="target-dvwa"

sudo docker run --rm -it -P --name target-dvwa -v volumes:/var/log/pcap -p 80:80 $(sudo docker images | grep $CONTAINER | awk '{print $3}')
sudo docker rmi -f $(sudo docker images | grep $CONTAINER | awk '{print $3}')
```

# sources 
https://danielmiessler.com/study/tcpdump/