#!/usr/bin/perl

#
# Source: http://hup.hu/node/125845
#
# Find the nearest wifi AP.
#
# TODO: Make it OSX compatible.
#

$if=wlan0;

@v=`sudo iwlist $if scan`;
$i=0;
$bestq=0;
while ($i < $#v ) {

if ($v[$i] =~ /ESSID:"(MAVSTART.+)"$/ ) {
$essid=$1;
$v[$i-2] =~ /Quality=(\S+)\s+/;
$q=$1;
if ($q > $bestq) {
$bestq = $q;
$bestessid = $essid;
}
}
$i++;
}
print "$bestessid";