#!/bin/bash
systemctl daemon-reload
systemctl start IpManager
systemctl enable IpManager
