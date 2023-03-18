export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
BIRed='\033[1;91m'
red='\e[1;31m'
bo='\e[1m'
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
# // Export Banner Status Information
export EROR="[${RED} ERROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

export ver1=$( curl -s https://raw.githubusercontent.com/NevermoreSSH/Blueblue/main/test/versions)
export ver2=$( cat /home/.ver)
if [[ $ver1 == $ver2 ]]; then
        echo -e "${LIGHT} ${BOLD}Your Script Last Update ${NC}"
        skip='true'
    else
        echo -e ${LIGHT} ${BOLD}Pacth $ver1 Already To Update....! ${NC}"
        echo -ne "${CYAN} ${BOLD}Update Now Or Later (y/n) ? ${NC}"
        read answer
        if [ "$answer" == "${answer#[Yy]}" ] ;then
        exit 0
    fi
        echo -e "${LIGHT} ${BOLD} Downloading Data....! ${NC}"
cat > /home/.ver << END
3.0
END        
        
 fi
