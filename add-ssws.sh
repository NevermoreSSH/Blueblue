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


clear
sspwd=$(cat /etc/xray/passwd)
clear
source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

tls="$(cat ~/log-install.txt | grep -w "Sodosok WS/GRPC" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m"
echo -e "\\E[0;41;36m      Add Sodosok Ws/Grpc Account    \E[0m"
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m"

		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
            echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m"
            echo -e "\\E[0;41;36m      Add Sodosok Ws/Grpc Account      \E[0m"
            echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
v2ray-menu
		fi
	done

cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#ssws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#ssgrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;path=/ss-ws;host=$domain;tls#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;serviceName=ss-grpc;host=$domain;tls#${user}"

#buat ss WEBSOCKET
sslinkws="ss://${shadowsocks_base64e}@${domain}:443?path=/ss-ws&security=tls&encryption=none&type=ws#${user}"
nonsslinkws="ss://${shadowsocks_base64e}@${domain}:80?path=/ss-ws&security=none&encryption=none&type=ws#${user}"

#buat ss GRPC
sslinkgrpc="ss://${shadowsocks_base64e}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=ss-grpc&sni=bug.com#${user}"
nonsslinkgrpc="ss://${shadowsocks_base64e}@${domain}:80?mode=gun&security=none&encryption=none&type=grpc&serviceName=ss-grpc&sni=bug.com#${user}"

systemctl restart xray
#buatshadowsocks custom
rm -rf /tmp/log
rm -rf /tmp/log1
cat > /home/vps/public_html/sodosokws-$user.txt <<-END
{ 
 "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "$domain",
            "level": 8,
            "method": "$cipher",
            "password": "$uuid",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "isi_bug_disini"
        },
        "wsSettings": {
          "headers": {
            "Host": "$domain"
          },
          "path": "/ss-ws"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
}
END
cat > /home/vps/public_html/sodosokgrpc-$user.txt <<-END
{
    "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "$domain",
            "level": 8,
            "method": "$cipher",
            "password": "$uuid",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "grpcSettings": {
          "multiMode": true,
          "serviceName": "ss-grpc"
        },
        "network": "grpc",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "isi_bug_disini"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
}
END
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "\\E[0;41;36m        Sodosok WS/GRPC Account    \E[0m" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "Remarks : ${user}" | tee -a /etc/log-create-user.log
echo -e "Domain : ${domain}" | tee -a /etc/log-create-user.log
echo -e "Port WS : ${tls}/80" | tee -a /etc/log-create-user.log
echo -e "Port GRPC : ${tls}" | tee -a /etc/log-create-user.log
echo -e "Password : ${uuid}" | tee -a /etc/log-create-user.log
echo -e "Cipers : aes-128-gcm" | tee -a /etc/log-create-user.log
echo -e "Network : ws/grpc" | tee -a /etc/log-create-user.log
echo -e "Path : /ss-ws" | tee -a /etc/log-create-user.log
echo -e "ServiceName : ss-grpc" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link WS TLS : ${sslinkws}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link WS None TLS : ${nonsslinkws}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link GRPC TLS : ${sslinkgrpc}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link GRPC None TLS : ${nonsslinkgrpc}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link JSON WS : http://${domain}:81/sodosokws-$user.txt" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link JSON gRPC : http://${domain}:81/sodosokgrpc-$user.txt" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo -e "Expired On : $exp" | tee -a /etc/log-create-user.log
echo -e "\033[0;34mג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”ג”\033[0m" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"

menu
