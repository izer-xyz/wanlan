#!/bin/sh

uci set network.wan=interface
uci set network.wan.proto='dhcp'

uci del wireless.default_radio0

uci set wireless.wifinet1=wifi-iface
uci set wireless.wifinet1.device='radio0'
uci set wireless.wifinet1.mode='sta'
uci set wireless.wifinet1.network='wan'
uci set wireless.wifinet1.encryption='psk2'
uci set wireless.wifinet1.ssid="$1"
uci set wireless.wifinet1.key="$2"

uci commit network
uci commit wireless

service network reload
