#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'
clear
MYIP=$(wget -qO- ipinfo.io/ip);

clear
setbot() {
clear
rm -rf /etc/.maA*
rm -rf /etc/token_bott
rm -rf /etc/admin_id
wget -O /usr/bin/botautobckp "https://cdn.discordapp.com/attachments/1071437252179263528/1071437304096370741/botautobckp.sh" && chmod +x /usr/bin/botautobckp
clear
firtsTimeRun() {

    [[ ! -f /usr/bin/jq ]] && {
        wget -q --no-check-certificate "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" -O /usr/bin/jq
        chmod +x usr/bin/jq
    }
    [[ ! -d /etc/.maAsiss ]] && mkdir -p /etc/.maAsiss
    [[ ! -f /etc/.maAsiss/.botku ]] && {
        wget -qO- https://cdn.discordapp.com/attachments/1071437252179263528/1071437296475324507/BotAPI.sh >/etc/.maAsiss/.botku
    }
    [[ ! -f /etc/.maAsiss/backup.conf ]] && {
        echo -ne "Insert your Bot TOKEN : "
        read bot_tkn
        echo "Token: $bot_tkn" > /etc/.maAsiss/backup.conf
        echo "Token: $bot_tkn" > /etc/token_bott
        echo -ne "Insert your Admin ID  : "
        read adm_ids
        echo "AdminID: $adm_ids" >> /etc/.maAsiss/backup.conf
        echo "AdminID: $adm_ids" >> /etc/admin_id
    }
}

firtsTimeRun
backup_bot

fun_bot1() {
			[[ "$(grep -wc "vpnlegasibot" "/etc/rc.local")" = '0' ]] && {
			    sed -i '$ i\screen -dmS vpnlegasibot backup_bot' /etc/rc.local >/dev/null 2>&1
			}
        }
        screen -dmS vpnlegasibot backup_bot >/dev/null 2>&1
        fun_bot1
        [[ $(ps x | grep "vpnlegasibot" | grep -v grep | wc -l) != '0' ]] && echo -e "\nBot successfully activated !" || echo -e "\nError1! Information not valid !"
        sleep 2
        menu
        } || {
       clear
        echo -e "Info...\n"
        fun_bot2() {
            screen -r -S "vpnlegasibot" -X quit >/dev/null 2>&1
            [[ $(grep -wc "vpnlegasibot" /etc/rc.local) != '0' ]] && {
                sed -i '/vpnlegasibot/d' /etc/rc.local
            }
            rm -f /etc/.maAsiss/backup.conf
            sleep 1
        }
        fun_bot2
        echo -e "\nBot Reseller Stopped!"
        sleep 2
        menu
clear
rm -rf /etc/.maA*
rm -rf setbot.sh
backupmenu       
}

backup_bot() {
clear
IP=$MYIP
date=$(date +"%Y-%m-%d")
token=$(cat /etc/token_bott | awk '{print $2}')
admin=$(cat /etc/admin_id | awk '{print $2}')
clear
if [[ -z $token ]]; then
echo -e "[ ${green}INFO${NC} ] Please Setbot First !"
sleep 3
clear
backupmenu
fi

echo -e "[ ${green}INFO${NC} ] Backup VPS Data In Progress . . ."
echo ""
rm -rf /root/backup
mkdir -p /root/backup
cp -r /usr/local/etc/xray/*.json /root/backup/ >/dev/null 2>&1
cp -r /usr/local/etc/xray/*.conf /root/backup/ >/dev/null 2>&1
cp -r /usr/local/etc/xray/configlogs /root/backup/ >/dev/null 2>&1
cp -r /usr/local/etc/xray/port /root/backup/ >/dev/null 2>&1
cp -r /home/vps/public_html /root/backup/public_html
cp -r /etc/cron.d /root/backup/cron.d &> /dev/null
cp -r /etc/crontab /root/backup/crontab &> /dev/null
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
curl --request POST \
  --url https://api.telegram.org/bot$token/sendDocument?chat_id=$admin \
  --header 'content-type: multipart/form-data' \
  --form document=@/root/$IP-$date.zip \
  --form 'caption=Here Is Your Backup Files'
clear
rm -rf backup >/dev/null 2>&1
rm -f /root/$IP-$date.zip >/dev/null 2>&1
backupmenu
}

restore() {
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[0;41;36m          RESTORE DATA VPS          \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e ""
read -p " Link File: " url
wget -O backup.zip "$url" &>/dev/null
echo -e "[ ${green}INFO${NC} ] Getting Your Data..."
unzip /root/backup/backup.zip &>/dev/null
echo -e "[ ${green}INFO${NC} ] Starting To Restore Data..."
rm -f backup.zip &>/dev/null
sleep 1
cp -r /root/backup/*.json /usr/local/etc/xray/ &> /dev/null
cp -r /root/backup/*.conf /usr/local/etc/xray/ &> /dev/null
cp -r /root/backup/configlogs /usr/local/etc/xray/ &> /dev/null
cp -r /root/backup/port /usr/local/etc/xray/ &> /dev/null
cp -r /root/backup/public_html /home/vps/ &> /dev/null
cp -r /root/backup/crontab /etc/ &> /dev/null
cp -r /root/backup/cron.d /etc/ &> /dev/null
rm -rf /root/backup &>/dev/null
echo -e "[ ${green}INFO${NC} ] VPS Data Restore Complete !"
sleep 1
rm -rf /root/backup
rm -f backup.zip
cd
sleep 3
clear
echo -e "[ ${green}INFO${NC} ] Restart All Service"
systemctl restart nginx
systemctl restart xray.service
systemctl restart xray@none.service
systemctl restart trojan-go.service
service cron restart
sleep 0.5
echo""
backupmenu
}

clear
cek=$(grep -c -E "^# BOTBEGIN_Backupp" /etc/crontab)
if [[ "$cek" = "1" ]]; then
sts="${green}ON${NC}"
else
sts="${red}OFF${NC}"
fi
start() {
clear
sed -i "/^# BOTBEGIN_Backupp/,/^# BOTEND_Backupp/d" /etc/crontab
cat << EOF >> /etc/crontab
# BOTBEGIN_Backupp
5 0 * * * root /usr/bin/botautobckp
# BOTEND_Backupp
EOF
service cron restart
echo " Please Wait"
sleep 1
clear
echo " Autobackup Has Been Started"
echo " Data Will Be Backup Automatically at 00:05"
sleep 1
clear
backupmenu
}
function stop() {
sed -i "/^# BOTBEGIN_Backupp/,/^# BOTEND_Backupp/d" /etc/crontab
service cron restart
echo " Please Wait"
sleep 1
clear
echo " Autobackup Has Been Stopped"
sleep 1
backupmenu
}

clear
echo -e "\033[0;34m────────────────────────────────────\033[0m"
echo -e "\E[0;41;36m          BACKUP DATA MENU          \E[0m"
echo -e "\033[0;34m────────────────────────────────────\033[0m"
echo -e " Status AutoBackup : $sts"
echo ""
echo -e " [\e[36m 1 \e[0m] ${red}• ${NC} Setup Bot Backup Data"
echo -e " [\e[36m 2 \e[0m] ${red}• ${NC} Start Bot Autobackup"
echo -e " [\e[36m 3 \e[0m] ${red}• ${NC} Stop Bot Autobackup"
echo -e " [\e[36m 4 \e[0m] ${red}• ${NC} Backup Data VPS"
echo -e " [\e[36m 5 \e[0m] ${red}• ${NC} Restore Data VPS"
echo -e " [\e[36m 6 \e[0m] ${red}• ${NC} Back To Main Menu"
echo -e ""
echo -e "\033[0;34m────────────────────────────────────\033[0m"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1)
    clear
    setbot
    ;;
2)
    clear
    start
    ;;
3)
    clear
    stop
    ;;
4)
    clear
    backup_bot
    ;;
5)
    clear
    restore
    ;;
6)  clear
    menu
    ;;
*)
    echo "Please enter an correct number !"
    sleep 1
    backupmenu
    ;;
esac
