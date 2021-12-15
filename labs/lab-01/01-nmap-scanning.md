# NMAP Scanning

### Disclaimer
    Some of the NMAP flags (Host Discovery) were not performing as expected, I'll need to do more research/troubleshooting to figure out why.

* Use NMAP to scan the DVWA
### Info Given
* Target IP range `<iprange>/24`
* There seems to be an unsecure web-app being hosted by a `examplecorp.com`

### Goal
1. Find the IP addr of the vulnerable site
2. Attempt host discovery
3. Identify what port the vulnerable app is running on
4. Identify what service/version is running the app
5. Identify the OS of the host machine running the site


# Steps
### Find the IP addr of the vulnerable site
`ping examplecorp.com`
First we want to identify the logical address of the vulnerable site. To find the logical address we can do one of a few things, including `dig`, `ping`, `nslookup`, or a `whois` search. (ONLY ping will work for this lab, could add the ability to do the DNS lookups, but it would require more time.)

### Attempt Host discovery
`nmap -n -sn <ip>/24`  
`nmap -n -Pn <ip>` OR `nmap -n -Pn examplecorp.com`  
Now that we have the IP address, lets see if theres anything else interesting in the same local subnet. We can do this by scanning the `/24` range it is a part of, this may not return anything interesting, but it helps us to become more familiar with our target.

### Identify what port the vulnerable app is running on
`nmap -sS <ip>` OR `nmap -sS examplecorp.com`  
`nmap -sT <ip>` OR `nmap -sT examplecorp.com`  
`nmap -sU <ip>` OR `nmap -sU examplecorp.com`  
Ok, so now we have the logical address and have searched for any of its logical neighbors, now lets start to drill down into our target. We want to see what ports are open and responding. We can determine this through port scanning. There are a few different options, we can generally just rely on the `sS` scan to see what TCP ports are available, but we may want to use the `sT` scan to make our scanning a little less obvious. Lastly, it is good practice to check for UDP ports too, since the `sS/sT` scans only do TCP scanning, lets use `sU` instead.

### Identify what service/version is running the app
`nmap -sV <ip>` OR `nmap -sV examplecorp.com`  
Alright, now we have a portmap, an idea of the local network, and the logical address of our target. Lets try and see what is actually running on our target. Run a service scan (`sV`) to try and determine what services are being offered by the ports we saw earlier.

### Identify the OS of the host machine running the site
`nmap -O <ip>` OR `nmap -O examplecorp.com`   
`nmap -O --fuzzy <ip>` OR `nmap -O --fuzzy examplecorp.com`  
Once we know what services are likely running on the target, its a good idea to figure out what OS the target is running on too. 

# Index
## Host Discovery 
- -sn : Ping Scan
    * This essentially does an ARP scan
    * Lets take a look at the Wireshark output
        - If we filter for `arp` and examine the resulting packets, we can see that each packet only goes up to layer 2, with a psuedo layer at layer 3  
- -Pn : Treat all as online (skip host discovery)
    * This option tells Nmap not to do a port scan after host discovery, and only print out the available hosts that responded to the host discovery probes.
    * Nmap continues to perform requested functions as if each target IP is active.
    * This means that if it is combined with A/sV/sS/sN etc it will continue to attempt the full scan w/o checking if the host is alive. This can help to identify services that are "hidden".

## Port Scanning
- -sS: TCP SYN
    * SYN scan is the default scan 
    * allows clear, reliable differentiation between the open, closed, and filtered states
    * 
- -sT: TCP Connect
    * TCP connect scan is the default TCP scan type when a user does not have raw packet privileges.
    * This will attempt a complete 3 way Handshake (SYN, SYN/ACK, ACK (+RST))
- -sU: UDP
    * works by sending a UDP packet to every targeted port.
    * UDP scanning is generally slower and more difficult than TCP.

## Service & Version Detection
- -sV: Version Detection
    * Use to try and determine what version of the service is being served from the ports.

## OS Detection
- -O: 
    * Enables OS Detection
    * Uses TCP/IP stack fingerprinting. Sends a series of TCP/UDP packets and examines practically every bit in the responses. 
    * Performs a bunch of tests
        - TCP ISN sampling
        - TCP options support and ordering
        - IP ID sampling
        - Initial window size check
    * Compares the results against `nmap-os-db` database
- --fuzzy: 
    * When Nmap is unable to detect a perfect OS match, it sometimes offers up near-matches as possibilities. 
    * This is useful when you get results like `No exact OS matches for host`