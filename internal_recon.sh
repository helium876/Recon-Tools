# Define an array of ports and corresponding service names
declare -A services=(
    [21]="ftp"
    [22]="ssh"
    [23]="telnet"
    [80]="http"
    [8080,8089]="http8080"
    [443]="https"
    [445]="smb"
    [3389]="rdp"
    [5900]="vnc"
    [88,389,636]="ldap"
    [3306]="mysql"
    [5432]="postgresql"
    [53]="dns"
    [25,465,587]="smtp"
    [143,993]="imap"
    [110,995]="pop3"
    [161]="snmp"
    [5060]="sip"
    [9200]="elasticsearch"
    [27017]="mongodb"
)

# Nmap scanning loop
for port in "${!services[@]}"; do
    service=${services[$port]}
    nmap -Pn -p $port -n --open -iL targets/alive.txt -oA scans/$service
done

# Extracting IPs from scan results loop
for service in "${services[@]}"; do
    cat scans/$service.nmap | grep for | cut -d " " -f 5 > targets/$service.txt
done

crackmapexec smb targets/smb.txt | tee -a smb-os-versionst.txt

for i in $(cat targets/smb.txt);do smbmap -H $i; done | tee -a smbmap-output.txt
