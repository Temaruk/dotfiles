#!/bin/sh

#
# MAV wifi script
#
# Source: http://hup.hu/node/125845
#
# TODO: Make it OSX compatible. (done? verify!)
#

SCRIPT_PATH=$(dirname `which $0`)

if=wlan0
post=$SCRIPT_PATH/mavstart.post

#disable interface
ifconfig $if down

# Generate random mac address.
macaddr=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`

# linux mac spoof
# macchanger -A $if

# osx mac spoof
# Sources:
# - http://osxdaily.com/2012/03/01/change-mac-address-os-x/
# - http://osxdaily.com/2008/01/17/how-to-spoof-your-mac-address-in-mac-os-x/
ifconfig $if Wi-Fi $macaddr

# enable interface
ifconfig $if up

# linux connect to wifi network
# iwconfig $if essid `mavessid.pl`
# sleep 3
# iwconfig

# osx connect to wifi network
# Source: http://superuser.com/questions/286457/connect-to-wifi-network-using-mac-terminal
ssid=`mavessid.pl`
networksetup -setairportnetwork $if $ssid

# linux dhcp renew
# dhclient $if

# osx dhcp renew
ipconfig set $if DHCP

ifconfig
curl http://captive-portal.mav-start.hu/add_host.php?redirect=google.hu%2f%3f --data @$post