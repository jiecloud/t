#!/bin/bash
route add default gw 45.43.14.1
sysctl -w net.ipv4.ip_forward=1
sysctl -p
route -n
ping -c 3 g.cn
