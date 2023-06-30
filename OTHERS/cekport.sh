#!/bin/bash
clear
NC='\e[0m'
## Foreground
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
trgo=$(cat /usr/local/etc/xray/port/port-trgo)

echo ""
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "      ${WB}Multiport Websocket Autoscript By Vinstechmy${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${WB}»»» Protocol Service «««  |  »»» Network Protocol «««${NC}  "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Vmess Websocket${NC}         ${WB}|${NC}  ${RB}♦️${NC}${YB} Websocket (CDN) TLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Vless Websocket${NC}         ${WB}|${NC}  ${RB}♦️${NC}${YB} Websocket (CDN) NTLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Trojan Websocket${NC}        ${WB}|${NC}  ${RB}♦️${NC}${YB} TCP XTLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Vless TCP XTLS${NC}          ${WB}|${NC}  ${RB}♦️${NC}${YB} TCP TLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Trojan TCP TLS${NC}          ${WB}|${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Trojan GO WS${NC}            ${WB}|${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "           ${WB}»»» YAML Service Information «««${NC}          "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY VMESS WS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY VLESS WS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY TROJAN WS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY VLESS TCP XTLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY TROJAN TCP TLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY TROJAN GO WS${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "             ${WB}»»» Server Information «««${NC}                 "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Timezone                : Asia/Kuala Lumpur (GMT +8)${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Fail2Ban                : [ON]${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Deflate                 : [ON]${NC}"
echo -e "  ${RB}♦️${NC} ${YB}IPtables                : [ON]${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Auto-Reboot             : [ON]${NC}"
echo -e "  ${RB}♦️${NC} ${YB}IPV6                    : [OFF]${NC}"
echo -e ""
echo -e "  ${RB}♦️${NC} ${YB}Autoreboot On 06.00 GMT +8${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Autobackup On 12:05 GMT +8${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Backup VPS Data Via Telegram Bot${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Backup & Restore VPS Data${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Automatic Delete Expired Account${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Bandwith Monitor${NC}"
echo -e "  ${RB}♦️${NC} ${YB}RAM & CPU Monitor${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Check Login User${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Check Created Config${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Automatic Clear Log${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Media Checker${NC}"
echo -e "  ${RB}♦️${NC} ${YB}DNS Changer${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "              ${WB}»»» Network Port Service «««${NC}             "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Vmess Websocket TLS${NC}          ${YB}: 443${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Vless Websocket TLS${NC}          ${YB}: 443${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Trojan Websocket TLS${NC}         ${YB}: 443${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Vless TCP XTLS${NC}               ${YB}: 443${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Trojan TCP TLS${NC}               ${YB}: 443${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Vmess Websocket None TLS${NC}     ${YB}: 80${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Vless Websocket None TLS${NC}     ${YB}: 80${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Trojan Websocket None TLS${NC}    ${YB}: 80${NC}"
echo -e "  ${RB}♦️${NC} ${YB}XRAY Trojan GO WS${NC}                 ${YB}: $trgo${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo ""

read -n 1 -s -r -p "Press any key to back on menu"
menu