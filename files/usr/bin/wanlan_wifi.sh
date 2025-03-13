#!/bin/sh

# use dhcp on wan (the below wifi)
uci set network.wan=interface
uci set network.wan.proto='dhcp'

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

uci commit firewall
uci commit network
uci commit wireless

service firewall restart
service network reload
