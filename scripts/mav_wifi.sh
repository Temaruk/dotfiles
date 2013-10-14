#!/bin/sh

#
# MAV wifi script
#
# Source: http://hup.hu/node/125845
#
# TODO: Make it OSX compatible.
#

SCRIPT_PATH=$(dirname `which $0`)

if=wlan0
post=$SCRIPT_PATH/mavstart.post

ifconfig $if down
macchanger -A $if
ifconfig $if up
iwconfig $if essid `mavessid.pl`
sleep 3
iwconfig

# linux dhcp renew
# dhclient $if

# osx dhcp renew
ipconfig set $if DHCP

ifconfig
curl http://captive-portal.mav-start.hu/add_host.php?redirect=google.hu%2f%3f --data @$post