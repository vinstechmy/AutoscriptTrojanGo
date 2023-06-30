#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'
echo -e "Please Insert  Your Domain"
read -p "Hostname / Domain: " host
rm -f /var/lib/dnsvps.conf
rm -f /usr/local/etc/xray/domain
echo "IP=$host" >> /var/lib/dnsvps.conf
echo "$host" > /usr/local/etc/xray/domain
clear
echo -e "Renew Certificate Started . . . ."
echo start
sleep 0.5
source /var/lib/dnsvps.conf
domain=$(cat /usr/local/etc/xray/domain)
systemctl stop nginx
systemctl stop xray.service
systemctl stop xray@none.service
systemctl stop trojan-go.service
sleep 1
echo -e "[ ${green}INFO${NC} ] Starting renew cert... "
rm -r /root/.acme.sh
sleep 1
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Restart All Service . . ." 
systemctl restart nginx
systemctl restart xray.service
systemctl restart xray@none.service
systemctl restart trojan-go.service
echo -e "[ ${green}INFO${NC} ] All finished . . ." 
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu