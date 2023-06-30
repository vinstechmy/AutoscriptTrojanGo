#!/bin/bash

MYIP=$(wget -qO- ipv4.icanhazip.com);
IP=$MYIP

date=$(date +"%Y-%m-%d")
token=$(cat /etc/token_bott | awk '{print $2}')
admin=$(cat /etc/admin_id | awk '{print $2}')

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
rm -rf backup
rm -f /root/$IP-$date.zip

