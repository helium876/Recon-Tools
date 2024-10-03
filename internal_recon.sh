# RECON Script
# Created by Helium

# mkdir targets
mkdir scans

# mv alive.txt targets/


# Nmap scanning commands
nmap -Pn -p 21 -n --open -iL targets/alive.txt -oA scans/ftp
nmap -Pn -p 22 -n --open -iL targets/alive.txt -oA scans/ssh
nmap -Pn -p 23 -n --open -iL targets/alive.txt -oA scans/telnet
nmap -Pn -p 80 -n --open -iL targets/alive.txt -oA scans/http
nmap -Pn -p 8080,8089 -n --open -iL targets/alive.txt -oA scans/http8080
nmap -Pn -p 443 -n --open -iL targets/alive.txt -oA scans/https
nmap -Pn -p 445 -n --open -iL targets/alive.txt -oA scans/smb
nmap -Pn -p 3389 -n --open -iL targets/alive.txt -oA scans/rdp
nmap -Pn -p 5900 -n --open -iL targets/alive.txt -oA scans/vnc
nmap -Pn -p 88,389,636 -n --open -iL targets/alive.txt -oA scans/ldap
nmap -Pn -p 3306 -n --open -iL targets/alive.txt -oA scans/mysql
nmap -Pn -p 5432 -n --open -iL targets/alive.txt -oA scans/postgresql
nmap -Pn -p 53 -n --open -iL targets/alive.txt -oA scans/dns
nmap -Pn -p 25,465,587 -n --open -iL targets/alive.txt -oA scans/smtp
nmap -Pn -p 143,993 -n --open -iL targets/alive.txt -oA scans/imap
nmap -Pn -p 110,995 -n --open -iL targets/alive.txt -oA scans/pop3
nmap -Pn -p 161 -n --open -iL targets/alive.txt -oA scans/snmp
nmap -Pn -p 5060 -n --open -iL targets/alive.txt -oA scans/sip
nmap -Pn -p 9200 -n --open -iL targets/alive.txt -oA scans/elasticsearch
nmap -Pn -p 27017 -n --open -iL targets/alive.txt -oA scans/mongodb


# Extracting IPs from scan results
cat scans/ftp.nmap | grep for | cut -d " " -f 5 > targets/ftp.txt
cat scans/ssh.nmap | grep for | cut -d " " -f 5 > targets/ssh.txt
cat scans/telnet.nmap | grep for | cut -d " " -f 5 > targets/telnet.txt
cat scans/http.nmap | grep for | cut -d " " -f 5 > targets/http.txt
cat scans/http8080.nmap | grep for | cut -d " " -f 5 > targets/http8080.txt
cat scans/https.nmap | grep for | cut -d " " -f 5 > targets/https.txt
cat scans/smb.nmap | grep for | cut -d " " -f 5 > targets/smb.txt
cat scans/rdp.nmap | grep for | cut -d " " -f 5 > targets/rdp.txt
cat scans/vnc.nmap | grep for | cut -d " " -f 5 > targets/vnc.txt
cat scans/ldap.nmap | grep for | cut -d " " -f 5 > targets/ldap.txt
cat scans/mysql.nmap | grep for | cut -d " " -f 5 > targets/mysql.txt
cat scans/postgresql.nmap | grep for | cut -d " " -f 5 > targets/postgresql.txt
cat scans/dns.nmap | grep for | cut -d " " -f 5 > targets/dns.txt
cat scans/smtp.nmap | grep for | cut -d " " -f 5 > targets/smtp.txt
cat scans/imap.nmap | grep for | cut -d " " -f 5 > targets/imap.txt
cat scans/pop3.nmap | grep for | cut -d " " -f 5 > targets/pop3.txt
cat scans/snmp.nmap | grep for | cut -d " " -f 5 > targets/snmp.txt
cat scans/sip.nmap | grep for | cut -d " " -f 5 > targets/sip.txt
cat scans/elasticsearch.nmap | grep for | cut -d " " -f 5 > targets/elasticsearch.txt
cat scans/mongodb.nmap | grep for | cut -d " " -f 5 > targets/mongodb.txt


crackmapexec smb targets/smb.txt | tee -a smb-os-versionst.txt

for i in $(cat targets/smb.txt);do smbmap -H $i; done | tee -a smbmap-output.txt
