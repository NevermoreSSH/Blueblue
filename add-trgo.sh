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
export ORANGE='\033[0;33m'
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

# // Validate Result ( 1 )
touch
clear
uuid=$(cat /etc/trojan-go/uuid.txt)
source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
trgo="$(cat ~/log-install.txt | grep -w "Trojan GO" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "User : " -e user
		user_EXISTS=$(grep -w $user /etc/trojan-go/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
read -p "Expired (Days) : " masaaktif
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan-go/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan-go/akun.conf
systemctl restart trojan-go.service
link="trojan-go://${uuid}@isi_bug_disini:${trgo}/?sni=${domain}&type=ws&host=${domain}&path=%2Ftrojango#$user"
link1="trojan://${uuid}@isi_bug_disini:${trgo}/?sni=${domain}&type=ws&host=${domain}&path=%2Ftrojango#$user"
clear
echo -e "\033[0;34mБ■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│\033[0m" | tee -a /etc/log-create-user.log
echo -e "\E[0;41;36m          TROJAN GO          \E[0m" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mБ■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│\033[0m" | tee -a /etc/log-create-user.log
echo -e "Remarks    : ${user}" | tee -a /etc/log-create-user.log
echo -e "IP/Host    : ${MYIP}" | tee -a /etc/log-create-user.log
echo -e "Address    : ${domain}" | tee -a /etc/log-create-user.log
echo -e "Port       : ${trgo}" | tee -a /etc/log-create-user.log
echo -e "Key        : ${uuid}" | tee -a /etc/log-create-user.log
echo -e "Network : ws/grpc" | tee -a /etc/log-create-user.log
echo -e "Encryption : none" | tee -a /etc/log-create-user.log
echo -e "Path       : /trojango" | tee -a /etc/log-create-user.log
echo -e "Created    : $hariini" | tee -a /etc/log-create-user.log
echo -e "Expired    : $exp" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mБ■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link TrGo  		: ${link}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mБ■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link TrGo (v2rayNG)	: ${link1}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mБ■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│Б■│\033[0m" | tee -a /etc/log-create-user.log
echo -e "Script Mod By NevermoreSSH"
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"

menu
