#!/bin/bash
clear
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}
res1() {
    systemctl fail2ban.service
}
res2() {
    systemctl restart cron.service
}
res3() {
    systemctl restart nginx.service
}
res4() {
    systemctl restart xray.service
	systemctl restart xray@none.service
}
res5() {
	systemctl restart trojan-go.service
}

clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m           RESTART SERVICE SERVER           \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo -e ""
echo -e "  \033[1;91m Service Restart Fail2ban\033[1;37m"
fun_bar 'res1'
echo -e "  \033[1;91m Service Restart Cron\033[1;37m"
fun_bar 'res2'
echo -e "  \033[1;91m Service Restart Nginx\033[1;37m"
fun_bar 'res3'
echo -e "  \033[1;91m Service Restart XRAY Core\033[1;37m"
fun_bar 'res4'
echo -e "  \033[1;91m Service Restart XRAY Trojan Go Core\033[1;37m"
fun_bar 'res5'
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
