#!/bin/bash
apt-get install john
apt-get install net-tools
systemctl daemon-reload
systemctl start IpManager
systemctl enable IpManager
