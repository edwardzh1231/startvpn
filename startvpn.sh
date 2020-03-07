#!/bin/bash
# Check if user has root access
if [ $(id -u) -ne 0 ]; then
	echo "ERROR: You need to be root to run this script" 
	exit 1
fi

# Generic UFW settings
ufw --force reset
ufw default deny outgoing
ufw default deny incoming
ufw allow in from 192.168.1.0/24
ufw allow out to 192.168.1.0/24
ufw allow in from 192.168.56.0/24
ufw allow out to 192.168.56.0/24
ufw allow in from 192.168.57.0/24
ufw allow out to 192.168.57.0/24
ufw allow in from 192.168.4.0/24
ufw allow out to 192.168.4.0/24
ufw allow in from 192.168.100.0/24
ufw allow out to 192.168.100.0/24
ufw allow out on tun0 from any to any
ufw allow 63879/tcp #aMule
ufw allow 63880/udp #aMule
ufw allow 63882/udp #aMule
ufw allow 51413 #BT


SERVERLIST=$(grep -v -e '^\s*$\|^\s*#' ./serverlist.txt) # Read server list file. Remove empty lines and lines start with #
for SERVERNAME in $SERVERLIST; do
	echo 
	echo "SERVERNAME: $SERVERNAME"
	SERVERIP=$(nslookup $SERVERNAME | sed 1,2d | grep Address | cut -d ' ' -f 2) # Get IP address from output of nslookup
	[ -z "SERVERIP" ] && continue
	for IP in $SERVERIP; do
		echo "IP address: $IP"
		ufw allow out from any to $IP
	done
done

ufw enable
ufw status
