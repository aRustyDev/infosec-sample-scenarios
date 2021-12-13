## Steps
### Find the IP addr of the vulnerable site
`ping examplecorp.com`

### Attempt Host discovery
`nmap -n -PS <ip>` OR `nmap -n -PS examplecorp.com`  
`nmap -n -PA <ip>` OR `nmap -n -PA examplecorp.com`  

### Identify what port the vulnerable app is running on
`nmap -n -sN <iprange>/24` OR `nmap -n -sN examplecorp.com`  
`nmap -n -sF <iprange>/24` OR `nmap -n -sF examplecorp.com`  

## Index
### Host Discovery 
- -PS : tcp syn
    * Will send a TCP SYN packet to the top 1000 ports on each host, then close the connection with a RST packet.
    * If the host responds with a SYN/ACK it will respond with an ACK
    * This can be used to test the functionality of a host and its network connections
- -PA : tcp ack
    * This is supposed to set the ACK flag instead, but is being buggy. 
    * This would normally be used to test for statefulness of a firewall. If a firewall is stateful, it would not let random TCP ACKs through, but a stateless would. 
        - This can be useful if an attacker wants to interact with machines that are behind a firewall

### Port Scanning
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
    * This sets the TCP ACK flag. 
    * This would normally be used to test for statefulness of a firewall. If a firewall is stateful, it would not let random TCP ACKs through, but a stateless would. 
        - This can be useful if an attacker wants to interact with machines that are behind a firewall

### Firewall/IDS/IPS Evasion & Spoofing

### Timing & Performance
- -T: Timing `paranoid|sneaky|polite|normal|aggressive|insane`