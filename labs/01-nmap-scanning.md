# NMAP Scanning

### Disclaimer
Some of the NMAP flags (Host Discovery) were not performing as expected, I'll need to do more research/troubleshooting to figure out why.

* Use NMAP to scan the DVWA
### Info Given
* Target IP range `<iprange>/24`
* There seems to be an unsecure web-app being hosted by a examplecorp.com

### Goal
1. Find the IP addr of the vulnerable site
2. Identify what port the vulnerable app is running on
3. Identify what service/version is running the app

Create a lab that demonstrates the difference between nmap flags and when to use them.

`nmap -n -sn <iprange>/24`

### Host Discovery 
- -sn : Ping Scan
    * This essentially does an ARP scan
    * Lets take a look at the Wireshark output
        - If we filter for `arp` and examine the resulting packets, we can see that each packet only goes up to layer 2, with a psuedo layer at layer 3  
- -Pn : Treat all as online (skip host discovery)
    * This option tells Nmap not to do a port scan after host discovery, and only print out the available hosts that responded to the host discovery probes.
    * Nmap continues to perform requested functions as if each target IP is active.
    * This means that if it is combined with A/sV/sS/sN etc it will continue to attempt the full scan w/o checking if the host is alive. This can help to identify services that are "hidden".
- -PS : tcp syn
    * Will send a TCP SYN packet to the top 1000 ports on each host, then close the connection with a RST packet.
    * If the host responds with a SYN/ACK it will respond with an ACK
    * This can be used to test the functionality of a host and its network connections
- -PA : tcp ack
    * This is supposed to set the ACK flag instead, but is being buggy. 
    * This would normally be used to test for statefulness of a firewall. If a firewall is stateful, it would not let random TCP ACKs through, but a stateless would. 
        - This can be useful if an attacker wants to interact with machines that are behind a firewall

### Port Scanning
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
- -sN: TCP NULL
    * Doesnt set ANY TCP flags 
    * Using NULL flags (NO FLAGS set) can help determine if a port is open or not. 
    * any packet not containing SYN, RST, or ACK bits will result in a returned RST if the port is closed and no response at all if the port is open
    * Does the same thing as `sF` & `sX`
- -sF: TCP FIN
    * Just Sets the FIN flag
    * Using FIN flag can help determine if a port is open or not. 
    * any packet not containing SYN, RST, or ACK bits will result in a returned RST if the port is closed and no response at all if the port is open
    * Does the same thing as `sX` & `sN`
- -sX: TCP XMAS
    * Sets FIN, PSH, & URG TCP flags.
    * Using FIN flag can help determine if a port is open or not. 
    * any packet not containing SYN, RST, or ACK bits will result in a returned RST if the port is closed and no response at all if the port is open
    * Does the same thing as `sF` & `sN`
- -sA: TCP ACK
    * 


### Service & Version Detection
- -sV: Version Detection
    * Use to try and determine what version of the service is being served from the ports.

### OS Detection
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
