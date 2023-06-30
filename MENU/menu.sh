#!/bin/bash
NC='\e[0m'
## Foreground
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GREEN='\e[0;32m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'

MYIP=$( curl -sS https://raw.githubusercontent.com/vinstechmy/AutoscriptTrojanGo/main/ACCESS/access | awk '{print $2}' )
Name=$(curl -sS https://raw.githubusercontent.com/vinstechmy/AutoscriptTrojanGo/main/ACCESS/access | grep $MYIP | awk '{print $4}')

xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# STATUS SERVICE XRAY
if [[ $xray_service == "running" ]]; then
   status_xray="${GB}ON${NC}"
else
   status_xray="${RB}OFF${NC}"
fi

# STATUS SERVICE NGINX
if [[ $nginx_service == "running" ]]; then
   status_nginx="${GB}ON${NC}"
else
   status_nginx="${RB}OFF${NC}"
fi

# // script version
myver="$(cat /home/ver)"

# // script version check
serverV=$( curl -sS https://raw.githubusercontent.com/vinstechmy/AutoscriptTrojanGo/main/UPDATE/version)

# // update script if available
function updatews(){
clear
echo -e "[ ${GREEN}INFO${NC} ] Check for Script updates . . ."
sleep 1
cd
wget -q -O /root/update.sh "https://raw.githubusercontent.com/vinstechmy/AutoscriptTrojanGo/main/UPDATE/update.sh" && chmod +x update.sh && ./update.sh
sleep 1
rm -f /root/update.sh
rm -f /home/ver
version_check=$( curl -sS https://raw.githubusercontent.com/vinstechmy/AutoscriptTrojanGo/main/UPDATE/version)
echo "$version_check" >> /home/ver
clear
echo ""
echo -e "[ ${GREEN}INFO${NC} ] Successfully Up To Date!"
sleep 1
echo ""
read -n 1 -s -r -p "Press any key to continue..."
menu
}

domain=$(cat /usr/local/etc/xray/domain)
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
WKT=$(cat /usr/local/etc/xray/timezone)
MYIP2=$(curl -sS ipv4.icanhazip.com)
SERONLINE=$(uptime -p | cut -d " " -f 2-10000)
load_cpu=$(printf '%-3s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
ram_used=$(free -m | grep Mem: | awk '{print $3}')
total_ram=$(free -m | grep Mem: | awk '{print $2}')
ram_usage=$(echo "scale=2; ($ram_used / $total_ram) * 100" | bc | cut -d. -f1)
daily_usage=$(vnstat -d --oneline | awk -F\; '{print $6}' | sed 's/ //')
monthly_usage=$(vnstat -m --oneline | awk -F\; '{print $11}' | sed 's/ //')

clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 INFO SERVER                \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo -e " ${YB}System Uptime${NC}    ${WB}: $SERONLINE${NC}"
echo -e " ${YB}Memory Usage${NC}     ${WB}: ${ram_used}MB / ${total_ram}MB (${ram_usage}%)${NC}"
echo -e " ${YB}CPU Load${NC}         ${WB}: $load_cpu${NC}"
echo -e " ${YB}ISP Provider${NC}     ${WB}: $ISP${NC}"
echo -e " ${YB}Timezone${NC}         ${WB}: $WKT${NC}"
echo -e " ${YB}City${NC}             ${WB}: $CITY${NC}"
echo -e " ${YB}IP Address${NC}       ${WB}: $MYIP2${NC}"
echo -e " ${YB}Domain${NC}           ${WB}: $domain${NC}"
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e "      [ XRAY-CORE${NC} : ${status_xray} ]  [ NGINX${NC} : ${status_nginx} ]"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo -e "    \033[1;37mNGINX FALLBACK MULTIPORT BY VINSTECHMY\033[0m"
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e "     ${WB}----- [ Bandwidth Monitoring ] -----${NC}"
echo -e ""
echo -e " Daily Data Usage   :  ${YB}$daily_usage${NC}"
echo -e " Monthly Data Usage :  ${YB}$monthly_usage${NC}"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 XRAY MENU                  \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m
 [\033[1;36m•1 \033[0m]  XRAY Vmess WS Panel
 [\033[1;36m•2 \033[0m]  XRAY Vless WS Panel
 [\033[1;36m•3 \033[0m]  XRAY Trojan WS Panel
 [\033[1;36m•4 \033[0m]  XRAY Vless TCP XTLS Panel
 [\033[1;36m•5 \033[0m]  XRAY Trojan TCP Panel
 [\033[1;36m•6 \033[0m]  XRAY Trojan GO WS Panel"
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                OTHERS MENU                 \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m
 [\033[1;36m•7 \033[0m]  DNS Changer
 [\033[1;36m•8 \033[0m]  Netflix Checker
 [\033[1;36m•9 \033[0m]  Limit Bandwith Speed"
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                SYSTEM MENU                 \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m
 [\033[1;36m•10\033[0m]  Change Domain
 [\033[1;36m•11\033[0m]  Renew Certificate
 [\033[1;36m•12\033[0m]  Check VPN Status
 [\033[1;36m•13\033[0m]  Check VPN Port
 [\033[1;36m•14\033[0m]  Restart VPN Services
 [\033[1;36m•15\033[0m]  Speedtest VPS
 [\033[1;36m•16\033[0m]  Check RAM & CPU Usage
 [\033[1;36m•17\033[0m]  Backup Data Via Telegram Bot
 [\033[1;36m•18\033[0m]  Backup & Restore
 [\033[1;36m•19\033[0m]  Reboot VPS
"
if [[ $serverV > $myver ]]; then
echo -e " [\033[1;36m•20\033[0m]  Update Autoscript To V$serverV\n"
up2u="updatews"
else
up2u="menu"
fi
echo -e " \033[1;37mType [ x ] To Exit From Menu \033[0m"
echo -e ""
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " Version       :\033[1;36m Nginx Fallback Multiport $myver\e[0m"
echo -e " Autoscript By : ${GB}$Name${NC}"
echo -e " Status Script : ${CB}Lifetime${NC}"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo -e ""
read -p " Select Menu :  "  opt
case $opt in
1) clear ; menu-ws ;;
2) clear ; menu-vless ;;
3) clear ; menu-tr ;;
4) clear ; menu-xray ;;
5) clear ; menu-xtr ;;
6) clear ; menu-trgo ;;
7) clear ; dns ; echo "" ; menu ;;
8) clear ; nf ; echo "" ; read -n1 -r -p "Press any key to continue..." ; menu ;;
9) clear ; limit ; echo "" ; menu ;;
10) clear ; add-host ;;
11) clear ; certxray ;;
12) clear ; status ; read -n1 -r -p "Press any key to continue..." ; menu ;;
13) clear ; cekport ;;
14) clear ; restart ; menu ;;
15) clear ; speedtest ; echo "" ; read -n1 -r -p "Press any key to continue..." ; menu ;;
16) clear ; gotop ; menu ;;
17) clear ; backupmenu ; menu ;;
18) clear ; get-backres ;;
19) clear ; reboot ;;
20) clear ; $up2u ; read -n1 -r -p "Press any key to continue..." ; menu ;;
00 | 0) clear ; menu ;;
x | X) exit ;;
*) clear ; menu ;;
esac