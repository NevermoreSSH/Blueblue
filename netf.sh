#!/bin/bash
#Script Updater By NevermoreSSH
Font_Black="\033[30m";
Font_Red="\033[31m";
Font_Green="\033[32m";
Font_Yellow="\033[33m";
Font_Blue="\033[34m";
Font_Purple="\033[35m";
Font_SkyBlue="\033[36m";
Font_White="\033[37m";
Font_Suffix="\033[0m";


clear;
echo -e "  \033[1;37m${Font_Purple}Media Stream Unlocker Test Mod By NevermoreSSH${Font_Suffix}\033[0m";
echo -e "  \033[1;37mVersion : ${Font_SkyBlue}${shell_version}${Font_Suffix}\033[0m";
echo -e "  \033[1;37mTime    : $(date)\033[0m"

export LANG="en_US.UTF-8";
export LANGUAGE="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

function InstallJQ() {
    if [ -e "/etc/redhat-release" ];then
        echo -e "${Font_Green}Installing dependencies: epel-release${Font_Suffix}";
        yum install epel-release -y -q > /dev/null;
        echo -e "${Font_Green}Installing dependencies: jq${Font_Suffix}";
        yum install jq -y -q > /dev/null;
    elif [[ $(cat /etc/os-release | grep '^ID=') =~ ubuntu ]] || [[ $(cat /etc/os-release | grep '^ID=') =~ debian ]];then
        echo -e "${Font_Green}Updating package list...${Font_Suffix}";
        apt-get update -y > /dev/null;
        echo -e "${Font_Green}Installing dependencies: jq${Font_Suffix}";
        apt-get install jq -y > /dev/null;
    else
        echo -e "${Font_Red}Please install jq manually${Font_Suffix}";
        exit;
    fi
}

function InstallCurl() {
    if [ -e "/etc/redhat-release" ];then
        echo -e "${Font_Green}Installing dependencies: curl${Font_Suffix}";
        yum install curl -y > /dev/null;
    elif [[ $(cat /etc/os-release | grep '^ID=') =~ ubuntu ]] || [[ $(cat /etc/os-release | grep '^ID=') =~ debian ]];then
        echo -e "${Font_Green}Updating package list...${Font_Suffix}";
        apt-get update -y > /dev/null;
        echo -e "${Font_Green}Installing dependencies: curl${Font_Suffix}";
        apt-get install curl -y > /dev/null;
    else
        echo -e "${Font_Red}请手动安装curl${Font_Suffix}";
        exit;
    fi
}

function PharseJSON() {
    # 使用方法: PharseJSON "要解析的原JSON文本" "要解析的键值"
    # Example: PharseJSON ""Value":"123456"" "Value" [返回结果: 123456]
    echo -n $1 | jq -r .$2;
}

function GameTest_Steam(){
    echo -n -e " Steam\t\t\t\t\t->\c";
    local result=$(curl --user-agent "${UA_Browser}" -${1} -fsSL --max-time 10 https://store.steampowered.com/app/761830 2>&1 | grep priceCurrency | cut -d '"' -f4);
    
    if [ ! -n "$result" ]; then
        echo -n -e "\r Steam\t\t\t\t\t: ${Font_Red}Failed (Network Connection)${Font_Suffix}\n";
    else
        echo -n -e "\r Steam\t\t\t\t\t: ${Font_Green}Yes(Currency: ${result})${Font_Suffix}\n";
    fi
}

function MediaUnlockTest_Netflix() {
    echo -n -e " Netflix\t\t\t\t->\c";
    local result1=$(curl $useNIC $xForward -${1} --user-agent "${UA_Browser}" -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://www.netflix.com/title/81403959" 2>&1)

    if [[ "$result1" == "404" ]]; then
        echo -n -e "\r Netflix\t\t\t\t: ${Font_Yellow}Originals Only${Font_Suffix}\n"
        return
    elif [[ "$result1" == "403" ]]; then
        echo -n -e "\r Netflix\t\t\t\t: ${Font_Red}No${Font_Suffix}\n"
        return
    elif [[ "$result1" == "200" ]]; then
        local region=$(curl $useNIC $xForward -${1} --user-agent "${UA_Browser}" -fs --max-time 10 --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/80018499" | cut -d '/' -f4 | cut -d '-' -f1 | tr [:lower:] [:upper:])
        if [[ ! -n "$region" ]]; then
            region="US"
        fi
        echo -n -e "\r Netflix\t\t\t\t: ${Font_Green}Yes(Region: ${region})${Font_Suffix}\n"
        return
    elif [[ "$result1" == "000" ]]; then
        echo -n -e "\r Netflix\t\t\t\t: ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return
    fi
}

function MediaUnlockTest_HotStar() {
    echo -n -e " HotStar\t\t\t\t->\c"
    local result=$(curl $useNIC $xForward --user-agent "${UA_Browser}" -${1} ${ssll} -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://api.hotstar.com/o/v1/page/1557?offset=0&size=20&tao=0&tas=20")
    if [ "$result" = "000" ]; then
        echo -n -e "\r HotStar\t\t\t\t: ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return
    elif [ "$result" = "401" ]; then
        local region=$(curl $useNIC $xForward --user-agent "${UA_Browser}" -${1} ${ssll} -sI "https://www.hotstar.com" | grep 'geo=' | sed 's/.*geo=//' | cut -f1 -d",")
        local site_region=$(curl $useNIC $xForward -${1} ${ssll} -s -o /dev/null -L --max-time 10 -w '%{url_effective}\n' "https://www.hotstar.com" | sed 's@.*com/@@' | tr [:lower:] [:upper:])
        if [ -n "$region" ] && [ "$region" = "$site_region" ]; then
            echo -n -e "\r HotStar\t\t\t\t: ${Font_Green}Yes(Region: $region)${Font_Suffix}\n"
            return
        else
            echo -n -e "\r HotStar\t\t\t\t: ${Font_Red}No${Font_Suffix}\n"
            return
        fi
    elif [ "$result" = "475" ]; then
        echo -n -e "\r HotStar\t\t\t\t: ${Font_Red}No${Font_Suffix}\n"
        return
    else
        echo -n -e "\r HotStar\t\t\t\t: ${Font_Red}Failed${Font_Suffix}\n"
    fi

}

function MediaUnlockTest_iQiyi(){
    echo -n -e " iQiyi Global\t\t\t\t->\c";
    local tmpresult=$(curl -${1} -s -I "https://www.iq.com/" 2>&1);
    if [[ "$tmpresult" == "curl"* ]];then
        	echo -n -e "\r iQiyi Global\t\t\t\t: ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        	return;
    fi
    
    local result=$(echo "${tmpresult}" | grep 'mod=' | awk '{print $2}' | cut -f2 -d'=' | cut -f1 -d';');
    if [ -n "$result" ]; then
		if [[ "$result" == "ntw" ]]; then
			echo -n -e "\r iQiyi Global\t\t\t\t: ${Font_Green}Yes(Region: TW)${Font_Suffix}\n"
			return;
		else
			result=$(echo ${result} | tr 'a-z' 'A-Z') 
			echo -n -e "\r iQiyi Global\t\t\t\t: ${Font_Green}Yes(Region: ${result})${Font_Suffix}\n"
			return;
		fi	
    else
		echo -n -e "\r iQiyi Global\t\t\t\t: ${Font_Red}Failed${Font_Suffix}\n"
		return;
	fi	
}

function MediaUnlockTest_Viu_com() {
    echo -n -e " Viu.com\t\t\t\t->\c";
    local tmpresult=$(curl -${1} -s -o /dev/null -L --max-time 30 -w '%{url_effective}\n' "https://www.viu.com/" 2>&1);
	if [[ "${tmpresult}" == "curl"* ]];then
        echo -n -e "\r Viu.com\t\t\t\t: ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return;
    fi
	
	local result=$(echo ${tmpresult} | cut -f5 -d"/")
	if [ -n "${result}" ]; then
		if [[ "${result}" == "no-service" ]]; then
			echo -n -e "\r Viu.com\t\t\t\t: ${Font_Red}No${Font_Suffix}\n"
			return;
		else
			result=$(echo ${result} | tr 'a-z' 'A-Z')
			echo -n -e "\r Viu.com\t\t\t\t: ${Font_Green}Yes(Region: ${result})${Font_Suffix}\n"
			return;
		fi
    else
		echo -n -e "\r Viu.com\t\t\t\t: ${Font_Red}Failed${Font_Suffix}\n"
		return;
	fi
}

function MediaUnlockTest_YouTube() {
    echo -n -e " YouTube\t\t\t\t->\c";
    local tmpresult=$(curl -${1} -s -H "Accept-Language: en" "https://www.youtube.com/premium")
    local region=$(curl --user-agent "${UA_Browser}" -${1} -sL "https://www.youtube.com/red" | sed 's/,/\n/g' | grep "countryCode" | cut -d '"' -f4)
	if [ -n "$region" ]; then
        sleep 0
	else
		region=US
	fi	
	
    if [[ "$tmpresult" == "curl"* ]];then
        echo -n -e "\r YouTube\t\t\t\t: ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return;
    fi
    
    local result=$(echo $tmpresult | grep 'Premium is not available in your country')
    if [ -n "$result" ]; then
        echo -n -e "\r YouTube\t\t\t\t: ${Font_Red}No Premium${Font_Suffix}(Region: ${region})${Font_Suffix} \n"
        return;
		
    fi
    local result=$(echo $tmpresult | grep 'YouTube and YouTube Music ad-free')
    if [ -n "$result" ]; then
        echo -n -e "\r YouTube\t\t\t\t: ${Font_Green}Yes(Region: ${region})${Font_Suffix}\n"
        return;
	else
		echo -n -e "\r YouTube\t\t\t\t: ${Font_Red}Failed${Font_Suffix}\n"
		
    fi	
	
    
}

function IPInfo() {
    local result=$(curl -fsSL http://ip-api.com/json/ 2>&1);
	
	echo -e -n " IP\t\t\t\t\t->\c";
    local ip=$(PharseJSON "${result}" "query");
	echo -e -n "\r IP\t\t\t\t\t: ${Font_Green}${ip}${Font_Suffix}\n";
	
	echo -e -n " Country\t\t\t\t->\c";
	local country=$(PharseJSON "${result}" "country");
	echo -e -n "\r Country\t\t\t\t: ${Font_Green}${country}${Font_Suffix}\n";
	
	echo -e -n " Region\t\t\t\t\t->\c";
	local region=$(PharseJSON "${result}" "regionName");
	echo -e -n "\r Region\t\t\t\t\t: ${Font_Green}${region}${Font_Suffix}\n";
	
	echo -e -n " City\t\t\t\t\t->\c";
	local city=$(PharseJSON "${result}" "city");
	echo -e -n "\r City\t\t\t\t\t: ${Font_Green}${city}${Font_Suffix}\n";
	
	echo -e -n " ISP\t\t\t\t\t->\c";
	local isp=$(PharseJSON "${result}" "isp");
	echo -e -n "\r ISP\t\t\t\t\t: ${Font_Green}${isp}${Font_Suffix}\n";
}

function MediaUnlockTest() {
	IPInfo ${1};
	
    global ${1};
}

function global() {
	echo -e "\n \033[1;37m${Font_Purple}-- Global --${Font_Suffix}\033[0m"
	MediaUnlockTest_Netflix ${1};
	MediaUnlockTest_HotStar ${1};
	MediaUnlockTest_YouTube ${1};
	MediaUnlockTest_iQiyi ${1};
	MediaUnlockTest_Viu_com ${1};
	GameTest_Steam ${1};
}

function startcheck() {
    mode=${1}
    mode=$(echo ${mode} | tr 'A-Z' 'a-z')
    if [[ "${mode}" != "" ]]; then
        case $mode in
            'global')
                IPInfo ${2};
                global ${2};
            ;;
            *)
                MediaUnlockTest ${2};
        esac
    else
        MediaUnlockTest ${2};
    fi
}

# install curl
if ! curl -V > /dev/null 2>&1;then
    InstallCurl;
fi

# install jq
if ! jq -V > /dev/null 2>&1;then
    InstallJQ;
fi

echo "";
echo -e " \033[1;37m${Font_Purple}-- IPV4 --${Font_Suffix}\033[0m";
check4=$(ping 1.1.1.1 -c 1 2>&1);
if [[ "$check4" != *"unreachable"* ]] && [[ "$check4" != *"Unreachable"* ]];then
    startcheck "${1}" "4";
else
    v4=""
    echo -e "${Font_SkyBlue}The current host does not support IPV4, skip...${Font_Suffix}";
fi

echo ""
echo -e " \033[1;37m${Font_Purple}-- IPV6 --${Font_Suffix}\033[0m";
check6=$(ping6 240c::6666 -c 1 2>&1);
if [[ "$check6" != *"unreachable"* ]] && [[ "$check6" != *"Unreachable"* ]];then
    v6="1"
else
    v6=""
    echo -e "${Font_SkyBlue}The current host does not support IPV6, skip...${Font_Suffix}";
fi
echo ""
echo -e "${Font_Green}Finished Test${Font_Suffix}"
echo ""
read -n1 -r -p "Press any key to continue..."