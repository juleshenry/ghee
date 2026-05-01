#!/bin/bash
# ============================================================================
# Module: Cybersecurity Network Recon
# Description: Ghee shortcuts and utilities for Cybersecurity Network Recon.
# ============================================================================

# Cybersecurity / Network Recon

_GG_REGISTRY["tn"]="telnet HOST ||| Telnet to a host"]
_GG_REGISTRY["tnp"]="telnet HOST PORT ||| Telnet to host:port"]
_GG_REGISTRY["nsa"]="netstat -an ||| Netstat all connections"]
_GG_REGISTRY["nstcp"]="netstat -tlnp ||| Netstat listening TCP ports"]
_GG_REGISTRY["nsudp"]="netstat -ulnp ||| Netstat listening UDP ports"]
_GG_REGISTRY["nsproc"]="netstat -tulnp ||| Netstat with process info"]
_GG_REGISTRY["nsest"]="netstat -an | grep ESTABLISHED ||| Netstat established connections"]
_GG_REGISTRY["nquick"]="nmap -F HOST ||| Nmap quick scan (top 100 ports)"]
_GG_REGISTRY["nfull"]="nmap -p- HOST ||| Nmap full TCP port scan"]
_GG_REGISTRY["nsvc"]="nmap -sV HOST ||| Nmap service version detection"]
_GG_REGISTRY["nos"]="sudo nmap -O HOST ||| Nmap OS detection"]
_GG_REGISTRY["nagg"]="sudo nmap -A HOST ||| Nmap aggressive scan (OS+ver+scripts)"]
_GG_REGISTRY["nsyn"]="sudo nmap -sS HOST ||| Nmap stealth SYN scan"]
_GG_REGISTRY["nudp"]="sudo nmap -sU HOST ||| Nmap UDP scan"]
_GG_REGISTRY["nsweep"]="nmap -sn SUBNET ||| Nmap ping sweep (discover hosts)"]
_GG_REGISTRY["nvuln"]="nmap --script vuln HOST ||| Nmap vulnerability scan"]
_GG_REGISTRY["nports"]="nmap -p PORTS HOST ||| Nmap scan specific ports"]
_GG_REGISTRY["nscript"]="nmap -sC HOST ||| Nmap scan with default scripts"]
_GG_REGISTRY["nmapxml"]="nmap -oX output.xml HOST ||| Nmap XML output for parsing"]
_GG_REGISTRY["ncl"]="nc -lvp PORT ||| Netcat listen on port"]
_GG_REGISTRY["ncs"]="nc HOST PORT ||| Netcat connect to host:port"]
_GG_REGISTRY["ncscan"]="nc -zv HOST START-END ||| Port scan with netcat"]
_GG_REGISTRY["sslcheck"]="openssl s_client + x509 DOMAIN ||| Check SSL certificate info"]
_GG_REGISTRY["sslchain"]="openssl s_client -showcerts DOMAIN ||| Show full SSL cert chain"]
_GG_REGISTRY["sslciphers"]="nmap ssl-enum-ciphers -p 443 DOMAIN ||| Enumerate SSL ciphers"]
_GG_REGISTRY["bannergrab"]="nc -w 3 HOST PORT ||| Banner grab via netcat"]
_GG_REGISTRY["myports"]="lsof -i -P -n | grep LISTEN ||| Show open ports on this host"]
_GG_REGISTRY["arptable"]="arp -a ||| Show ARP table"]
_GG_REGISTRY["routes"]="netstat -rn / ip route show ||| Show routing table"]
_GG_REGISTRY["fwrules"]="sudo iptables -L / pfctl -sr ||| Show firewall rules"]
_GG_REGISTRY["sniff"]="sudo tcpdump -i any -nn ||| Packet sniffing (tcpdump)"]
_GG_REGISTRY["tcapt"]="sudo tcpdump -w capture.pcap ||| Capture packets to file"]
_GG_REGISTRY["tcport"]="sudo tcpdump port PORT ||| tcpdump filter by port"]
_GG_REGISTRY["tchost"]="sudo tcpdump host HOST ||| tcpdump filter by host"]
_GG_REGISTRY["secheaders"]="curl -sI URL | grep security headers ||| Check HTTP security headers"]
_GG_REGISTRY["hashpw"]="echo -n PW | openssl dgst -sha512 ||| Hash a password (SHA-512)"]
_GG_REGISTRY["genpw"]="tr -dc A-Za-z0-9... < /dev/urandom ||| Generate random password"]
_GG_REGISTRY["worldwrite"]="find / -perm -0002 ||| Find world-writable files"]
_GG_REGISTRY["findsuid"]="find / -perm -4000 ||| Find SUID binaries"]
_GG_REGISTRY["whoson"]="who -a / w ||| Show all logged-in users"]

# 341. Telnet
alias tn='telnet'

# 342. Telnet to host:port (quick connectivity check)
tnp() {
    if [ -z "$2" ]; then
        echo "Usage: tnp HOST PORT"
        return 1
    fi
    telnet "$1" "$2"
}

# 343. Netstat all connections
alias nsa='netstat -an'

# 344. Netstat listening TCP
alias nstcp='netstat -tlnp 2>/dev/null || netstat -an -p tcp | grep LISTEN'

# 345. Netstat listening UDP
alias nsudp='netstat -ulnp 2>/dev/null || netstat -an -p udp'

# 346. Netstat with process info
alias nsproc='netstat -tulnp 2>/dev/null || lsof -i -P -n'

# 347. Netstat established connections
alias nsest='netstat -an | grep ESTABLISHED'

# 348. Nmap quick scan (top 100 ports)
alias nquick='nmap -F'

# 349. Nmap full TCP port scan
alias nfull='nmap -p-'

# 350. Nmap service version detection
alias nsvc='nmap -sV'

# 351. Nmap OS detection (requires root)
alias nos='sudo nmap -O'

# 352. Nmap aggressive scan (OS + version + scripts + traceroute)
alias nagg='sudo nmap -A'

# 353. Nmap stealth SYN scan
alias nsyn='sudo nmap -sS'

# 354. Nmap UDP scan
alias nudp='sudo nmap -sU'

# 355. Nmap ping sweep (discover hosts on subnet)
alias nsweep='nmap -sn'

# 356. Nmap vulnerability scan (default scripts)
alias nvuln='nmap --script vuln'

# 357. Nmap scan specific ports
nports() {
    if [ -z "$2" ]; then
        echo "Usage: nports HOST 'PORT1,PORT2,...'"
        return 1
    fi
    nmap -p "$2" "$1"
}

# 358. Nmap scan with all scripts
alias nscript='nmap -sC'

# 359. Nmap XML output for parsing
nmapxml() {
    if [ -z "$1" ]; then
        echo "Usage: nmapxml HOST [output.xml]"
        return 1
    fi
    nmap -oX "${2:-scan-$(date +%Y%m%d-%H%M%S).xml}" "$1"
}

# 360. Netcat listen on port
ncl() {
    if [ -z "$1" ]; then
        echo "Usage: ncl PORT"
        return 1
    fi
    nc -lvp "$1" 2>/dev/null || nc -l "$1"
}

# 361. Netcat send data to host:port
ncs() {
    if [ -z "$2" ]; then
        echo "Usage: ncs HOST PORT"
        return 1
    fi
    nc "$1" "$2"
}

# 362. Port scan with netcat (no nmap)
ncscan() {
    if [ -z "$2" ]; then
        echo "Usage: ncscan HOST 'START-END' (e.g., ncscan 10.0.0.1 '1-1024')"
        return 1
    fi
    nc -zv "$1" "$2" 2>&1
}

# 363. Check SSL/TLS certificate for a domain
sslcheck() {
    if [ -z "$1" ]; then
        echo "Usage: sslcheck DOMAIN"
        return 1
    fi
    echo | openssl s_client -servername "$1" -connect "$1:443" 2>/dev/null | openssl x509 -noout -dates -subject -issuer
}

# 364. Show full SSL cert chain
sslchain() {
    if [ -z "$1" ]; then
        echo "Usage: sslchain DOMAIN"
        return 1
    fi
    echo | openssl s_client -showcerts -servername "$1" -connect "$1:443" 2>/dev/null
}

# 365. SSL cipher enumeration
sslciphers() {
    if [ -z "$1" ]; then
        echo "Usage: sslciphers DOMAIN"
        return 1
    fi
    nmap --script ssl-enum-ciphers -p 443 "$1"
}

# 366. Banner grabbing (via netcat)
bannergrab() {
    if [ -z "$2" ]; then
        echo "Usage: bannergrab HOST PORT"
        return 1
    fi
    echo "" | nc -w 3 "$1" "$2" 2>&1
}

# 367. Show open TCP ports on this host
alias myports='lsof -i -P -n | grep LISTEN'

# 368. ARP table
alias arptable='arp -a'

# 369. Show routing table
alias routes='netstat -rn 2>/dev/null || ip route show'

# 370. Show firewall rules (Linux iptables)
alias fwrules='sudo iptables -L -n -v 2>/dev/null || sudo pfctl -sr 2>/dev/null'

# 371. tcpdump on interface (requires root)
alias sniff='sudo tcpdump -i any -nn'

# 372. tcpdump capture to file
tcapt() {
    if [ -z "$1" ]; then
        echo "Usage: tcapt INTERFACE [output.pcap]"
        return 1
    fi
    sudo tcpdump -i "$1" -w "${2:-capture-$(date +%Y%m%d-%H%M%S).pcap}"
}

# 373. tcpdump filter by port
tcport() {
    if [ -z "$1" ]; then
        echo "Usage: tcport PORT [interface]"
        return 1
    fi
    sudo tcpdump -i "${2:-any}" -nn port "$1"
}

# 374. tcpdump filter by host
tchost() {
    if [ -z "$1" ]; then
        echo "Usage: tchost HOST [interface]"
        return 1
    fi
    sudo tcpdump -i "${2:-any}" -nn host "$1"
}

# 375. HTTP security headers check
secheaders() {
    if [ -z "$1" ]; then
        echo "Usage: secheaders URL"
        return 1
    fi
    curl -sI "$1" | grep -iE '(strict-transport|content-security|x-frame|x-content|x-xss|referrer-policy|permissions-policy|feature-policy)'
}

# 376. Hash a password with sha512
hashpw() {
    if [ -z "$1" ]; then
        echo "Usage: hashpw PASSWORD"
        return 1
    fi
    echo -n "$1" | openssl dgst -sha512
}

# 377. Generate a random password
genpw() {
    local len="${1:-32}"
    LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*()_+=' < /dev/urandom | head -c "$len" && echo
}

# 378. Find world-writable files (potential security issue)
alias worldwrite='find / -xdev -type f -perm -0002 -ls 2>/dev/null'

# 379. Find SUID binaries
alias findsuid='find / -xdev -type f -perm -4000 -ls 2>/dev/null'

# 380. Show all logged-in users
alias whoson='who -a 2>/dev/null || w'


_GG_REGISTRY["b64e"]="echo -n STR | base64 ||| Base64 encode string"
_GG_REGISTRY["b64d"]="echo -n STR | base64 --decode ||| Base64 decode string"
_GG_REGISTRY["jwtdecode"]="jq -R 'split(\".\") | .[0],.[1] | @base64d | fromjson' ||| Decode JWT token"
_GG_REGISTRY["shodanip"]="curl -s https://internetdb.shodan.io/IP ||| Fast Shodan IP lookup"
_GG_REGISTRY["sshkey"]="ssh-keygen -t ed25519 -C EMAIL ||| Generate modern secure SSH key"

# Added by Ghee Superduper Upgrade
unalias b64e 2>/dev/null
function b64e() {
    echo -n "\$1" | base64
}
unalias b64d 2>/dev/null
function b64d() {
    echo -n "\$1" | base64 --decode
}
jwtdecode() {
    if [ -z "\$1" ]; then
        echo "Usage: jwtdecode <token>"
        return 1
    fi
    echo "\$1" | jq -R "split(\".\") | .[0],.[1] | @base64d | fromjson" 2>/dev/null || echo "Invalid JWT or jq not installed."
}
shodanip() {
    if [ -z "\$1" ]; then
        echo "Usage: shodanip <IP>"
        return 1
    fi
    curl -s "https://internetdb.shodan.io/\$1" | jq . 2>/dev/null || curl -s "https://internetdb.shodan.io/\$1"
}
alias sshkey='ssh-keygen -t ed25519 -C '
