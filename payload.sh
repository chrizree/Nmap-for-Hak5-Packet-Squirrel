#!/bin/bash 
# Nmap for the Packet Squirrel
# For IPv4 networks only

LED STAGE1

# NETMODE BRIDGE
# NETMODE TRANSPARENT
NETMODE NAT

sleep 30

LootPath="/mnt/loot/nmap"		    # Path to store results, note: requires a working USB storage device attached to the PS!
LOG="PSnmap_$(date +%Y-%m-%d-%H%M)"	# File name for scan results

#uci show network
#cat /etc/config/network

#IP address of default gateway
DEF_GW_IP=$(ip route show default | awk '/default/ {print $3}')
echo "------------------------------------------------------------" >> $LootPath/$LOG
echo "IP address of default gateway" >> $LootPath/$LOG
echo $DEF_GW_IP >> $LootPath/$LOG
echo "------------------------------------------------------------" >> $LootPath/$LOG
echo " " >> $LootPath/$LOG

#Interface name of default gateway
DEF_GW_IF=$(ip route show default | awk '/default/ {print $5}')
echo "------------------------------------------------------------" >> $LootPath/$LOG
echo "Interface name of default gateway" >> $LootPath/$LOG
echo $DEF_GW_IF >> $LootPath/$LOG
echo "------------------------------------------------------------" >> $LootPath/$LOG
echo " " >> $LootPath/$LOG

#Get subnet of the network that has the default gateway
R_NET=$(ip route show default | awk '/default/ {print $3}' | cut -d "." -f 1-3)
R_NET_EXT=".0"
R_NET="$R_NET$R_NET_EXT"
R_SUBNET=$(ip route show | grep $R_NET | cut -d " " -f1)
echo "------------------------------------------------------------" >> $LootPath/$LOG
echo "Interface name of default gateway" >> $LootPath/$LOG
echo $R_SUBNET >> $LootPath/$LOG
echo "------------------------------------------------------------" >> $LootPath/$LOG
echo " " >> $LootPath/$LOG

sleep 5

LED ATTACK

echo "------------------------------------------------------------" >> $LootPath/$LOG
echo "Nmap start" >> $LootPath/$LOG
echo " " >> $LootPath/$LOG
nmap -F -T 4 $R_SUBNET >> $LootPath/$LOG
echo " " >> $LootPath/$LOG
echo "------------------------------------------------------------" >> $LootPath/$LOG
echo " " >> $LootPath/$LOG
echo " " >> $LootPath/$LOG
echo "EOF" >> $LootPath/$LOG

LED FINISH

LED R VERYFAST
sleep 5
poweroff
