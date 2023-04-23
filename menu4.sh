BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="raw.githubusercontent.com/NevermoreSSH/Blueblue/main/test"
export Server1_URL="raw.githubusercontent.com/NevermoreSSH/Blueblue/main/limit"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther=".geovpn"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // Exporting Network Interface
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"

# // Clear
clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ON${NC}"
else
ressh="${red}OFF${NC}"
fi
sshstunel=$(service stunnel5 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ON${NC}"
else
resst="${red}OFF${NC}"
fi
sshws=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
ressshws="${green}ON${NC}"
else
ressshws="${red}OFF${NC}"
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${green}ON${NC}"
else
resdbr="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi
function addhost(){
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -rp "Domain/Host: " -e host
echo ""
if [ -z $host ]; then
echo "????"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
setting-menu
else
rm -fr /etc/xray/domain
echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
echo $host > /etc/xray/domain
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "Dont forget to renew gen-ssl"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
}
function genssl(){
clear
systemctl stop nginx
systemctl stop xray
domain=$(cat /var/lib/scrz-prem/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew gen-ssl... " 
sleep 2
/root/.acme.sh/acme.sh --upgrade
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew gen-ssl done... " 
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek " 
sleep 2
echo $domain > /etc/xray/domain
systemctl start nginx
systemctl start xray
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
export sem=$( curl -s https://raw.githubusercontent.com/NevermoreSSH/Blueblue/main/test/versions)
export pak=$( cat /home/.ver)
IPVPS=$(curl -s ipinfo.io/ip )
ISPVPS=$( curl -s ipinfo.io/org )
daily_usage=$(vnstat -d --oneline | awk -F\; '{print $6}' | sed 's/ //')
monthly_usage=$(vnstat -m --oneline | awk -F\; '{print $11}' | sed 's/ //')
ram_used=$(free -m | grep Mem: | awk '{print $3}')
total_ram=$(free -m | grep Mem: | awk '{print $2}')
ram_usage=$(echo "scale=2; ($ram_used / $total_ram) * 100" | bc | cut -d. -f1)
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*/} / ${corediilik:-1}))"
cpu_usage+="%"
cname=$(awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo)
cores=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
freq=$(awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo)
clear
echo -e "${BICyan} ┌────────────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │                  ${BIWhite}${UWhite}Server Informations${NC}"         
echo -e "${BICyan} │"                                                                      
echo -e "${BICyan} │  ${BICyan}OS Linux        :  "$(hostnamectl | grep "Operating System" | cut -d ' ' -f5-)  
echo -e "${BICyan} │  ${BICyan}Kernel          :  ${BICyan}$(uname -r)${NC}"  
echo -e "${BICyan} │  ${BICyan}CPU Name        : ${BIWhite}$cname${NC}"
echo -e "${BICyan} │  ${BICyan}CPU Info        :  ${BIWhite}$cores Cores @ $freq MHz (${cpu_usage}) ${NC}"
echo -e "${BICyan} │  ${BICyan}Total RAM       :  ${BIWhite}${ram_used}MB / ${total_ram}MB (${ram_usage}%) ${NC}" 
echo -e "${BICyan} │  ${BICyan}System Uptime   :  ${BIWhite}$uptime${NC}"
echo -e "${BICyan} │  ${BICyan}Current Domain  :  ${BIWhite}$(cat /etc/xray/domain)${NC}" 
echo -e "${BICyan} │  ${BICyan}IP-VPS          :  ${BIWhite}$IPVPS${NC}"                  
echo -e "${BICyan} │  ${BICyan}ISP-VPS         :  ${BIWhite}$ISPVPS${NC}"  
echo -e "${BICyan} │  ${BICyan}Daily Bandwidth :  ${BIWhite}$daily_usage ${NC}"
echo -e "${BICyan} │  ${BICyan}Total Bandwidth :  ${BIWhite}$monthly_usage ${NC}"
echo -e "${BICyan} └────────────────────────────────────────────────────────────┘${NC}"
echo -e "     ${BICyan} SSH ${NC}: $ressh"" ${BICyan} NGINX ${NC}: $resngx"" ${BICyan}  XRAY ${NC}: $resv2r"" ${BICyan} TROJAN ${NC}: $resv2r"
echo -e "     ${BICyan} DROPBEAR ${NC}: $resdbr" "${BICyan} SSH-WS ${NC}: $ressshws" Stunnel ${NC}: $sshstunel" "${BICyan}
echo -e "${BICyan} ┌────────────────────────────────────────────────────────────┐${NC}"
echo -e "     ${BICyan}[${BIWhite}01${BICyan}] SSHWS ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}02${BICyan}] VMESS ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}03${BICyan}] VLESS ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}04${BICyan}] TROJAN ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}05${BICyan}] SHADOWSOCKS ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}06${BICyan}] EXP FILES ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}07${BICyan}] AUTO REBOOT ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}08${BICyan}] REBOOT ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}09${BICyan}] RESTART ${BICyan}${BIYellow}${BICyan}${NC}"    
echo -e "     ${BICyan}[${BIWhite}10${BICyan}] BACKUP/RESTORE ${BICyan}${BIYellow}${BICyan}${NC}"   
echo -e "     ${BICyan}[${BIWhite}11${BICyan}] ADD HOST/DOMAIN ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}12${BICyan}] RENEW CERT ${BICyan}${BIYellow}${BICyan}${NC}"       
echo -e "     ${BICyan}[${BIWhite}13${BICyan}] EDIT BANNER ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}14${BICyan}] RUNNING STATUS ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}15${BICyan}] USER BANDWIDTH ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}16${BICyan}] SPEEDTEST ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}17${BICyan}] CHECK BANDWIDTH ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}18${BICyan}] LIMIT SPEED ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}19${BICyan}] WEBMIN ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}20${BICyan}] INFO SCRIPT ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}21${BICyan}] CLEAR LOG ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}22${BICyan}] FIX MISSING AUTO POINTING ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}23${BICyan}] DNS CHANGER ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}24${BICyan}] NETFLIX CHECKER ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e " "
echo -e "     ${BICyan}[${BIWhite}55${BICyan}] XRAY VERSION ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}66${BICyan}] INSTALL BBRPLUS ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}77${BICyan}] TENDANG ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}88${BICyan}] CHECK RAM ${BICyan}${BIYellow}${BICyan}${NC}"
echo -e "     ${BICyan}[${BIWhite}99${BICyan}] UPDATE ${BICyan}${BIYellow}${BICyan}${NC}" 
echo -e "     ${BICyan}[${BIWhite}x${BICyan}]  EXIT ${BICyan}${BIYellow}${BICyan}${NC}"  
echo -e "${BICyan} └────────────────────────────────────────────────────────────┘${NC}"
echo -e " ${BICyan}┌─────────────────────────────────────┐${NC}"
echo -e " ${BICyan}│  Version      ${NC} : $sem Last Update"    
echo -e " ${BICyan}└─────────────────────────────────────┘${NC}"
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-ss ;;
6) clear ; xp ;;
7) clear ; autoreboot ;;
8) clear ; reboot ;;
9) clear ; restart ;;
10) clear ; menu-bckp ;;
11) clear ; addhost ;;
12) clear ; genssl ;;
13) clear ; nano /etc/issue.net ;;
14) clear ; running ;;
15) clear ; cek-trafik ;;
16) clear ; cek-speed ;;
17) clear ; cek-bandwidth ;;
18) clear ; limit-speed ;;
19) clear ; wbm ;;
20) clear ; cat /root/log-install.txt ;;
21) clear ; clearlog ;;
55) clear ; xray version ;;
66) clear ; bbr ;;
77) clear ; tendang ;;
88) clear ; gotop ;;
#99) clear ; update ;;
#22) clear ; wget https://raw.githubusercontent.com/NevermoreSSH/Blueblue/main/cf.sh && chmod +x cf.sh && ./cf.sh ;;
23) clear ; dns ;;
24) clear ; netf ;;

0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
