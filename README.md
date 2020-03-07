startvpn.sh

This script works as an Internet Kill Switch for VPN. It utilized the UFW - Uncomplicated Firewall that comes with Ubuntu. 

It reads a list of VPN servers from serverlist.txt and allow traffic to those servers. Other than that, only local network and VPN tunnel is allowed. Thus, when VPN disconnects, Internet access is blocked.
  
