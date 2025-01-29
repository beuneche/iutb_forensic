#!/bin/bash
apt-get install -y john
apt-get install -y net-tools
systemctl daemon-reload
systemctl start IpManager
systemctl enable IpManager
rm -f /root/firststart.sh
