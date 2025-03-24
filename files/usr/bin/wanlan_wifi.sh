#!/bin/sh

if [ "$1" == "" ] || [ "$2" == "" ] ; then
   echo "Connect to wifi upstream. "
   echo "Usage:"
   echo "    "
   echo "    wanlan_wifi.sh <ssid> <key> [<encrytion>]"
   echo "    "
   echo "     - default encryption is psk2"
   echo "     - force DNS to 1.1.1.1"
   echo "     - disable Captive Portal"
   exit -1
fi

# use dhcp on wan (the below wifi)
uci set network.wan=interface
uci set network.wan.proto='dhcp'
uci set network.wan.peerdns='0'
uci add_list network.wan.dns='1.1.1.1'

# cleanu default/stock wifi
uci del wireless.default_radio0

# connect to wifi as new wan
uci set wireless.wifinet1=wifi-iface
uci set wireless.wifinet1.device='radio0'
uci set wireless.wifinet1.mode='sta'
uci set wireless.wifinet1.network='wan'
uci set wireless.wifinet1.encryption='psk2'
uci set wireless.wifinet1.ssid="$1"
uci set wireless.wifinet1.key="$2"

# disable captive portal
uci set firewall.captive.enabled='0'
uci set firewall.captives.enabled='0'

uci commit firewall
uci commit network
uci commit wireless

service firewall restart
service network reload
