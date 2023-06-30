#!/bin/bash
#Autoscript-Lite By Vinstechmy

#----- Auto Remove Vmess
data=( `cat /usr/local/etc/xray/config.json | grep '^#~&' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#~& $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#~& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
sed -i "/^#~& $user $exp/,/^},{/d" /usr/local/etc/xray/none.json
rm -f /usr/local/etc/xray/$user-tls.json /usr/local/etc/xray/$user-none.json
rm -f /home/vps/public_html/$user-VMESSTLS.yaml /home/vps/public_html/$user-VMESSNTLS.yaml
rm -f /usr/local/etc/xray/configlogs/vmessws-$user.txt
systemctl restart xray.service
systemctl restart xray@none.service
fi
done

#----- Auto Remove Vless
data=( `cat /usr/local/etc/xray/config.json | grep '^#@' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#@ $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#@ $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
sed -i "/^#@ $user $exp/,/^},{/d" /usr/local/etc/xray/none.json
rm -f /home/vps/public_html/$user-VLESSTLS.yaml /home/vps/public_html/$user-VLESSNTLS.yaml
rm -f /usr/local/etc/xray/configlogs/vlessws-$user.txt
systemctl restart xray.service
systemctl restart xray@none.service
fi
done

#----- Auto Remove Trojan
data=( `cat /usr/local/etc/xray/config.json | grep '^#&' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#& $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
sed -i "/^#& $user $exp/,/^},{/d" /usr/local/etc/xray/none.json
rm -f /home/vps/public_html/$user-TROJANTLS.yaml
rm -f /usr/local/etc/xray/configlogs/trojanws-$user.txt
systemctl restart xray.service
systemctl restart xray@none.service
fi
done

#----- Auto Remove Trojan TCP
data=( `cat /usr/local/etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
rm -f /home/vps/public_html/$user-TRTCP.yaml
rm -f /usr/local/etc/xray/configlogs/trojantcp-$user.txt
systemctl restart xray.service
fi
done

#----- Auto Remove Vless TCP XTLS
data=( `cat /usr/local/etc/xray/config.json | grep '^#!' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#! $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#! $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
rm -f /home/vps/public_html/$user-VLESSDIRECT.yaml /home/vps/public_html/$user-VLESSSPLICE.yaml
rm -f /usr/local/etc/xray/configlogs/vlessxtls-$user.txt
systemctl restart xray.service
fi
done

#----- Auto Remove Trojan-Go
data=( `cat /usr/local/etc/xray/akauntrgo.conf | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/usr/local/etc/xray/akauntrgo.conf" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/akauntrgo.conf
sed -i '/^,"'"$user"'"$/d' /usr/local/etc/xray/trgo.json
rm -f /home/vps/public_html/$user-TRGO.yaml /home/vps/public_html/$user-TRGOWS.yaml
rm -f /usr/local/etc/xray/configlogs/trojango-$user.txt
systemctl restart trojan-go.service
fi
done
