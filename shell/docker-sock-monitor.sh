#!/usr/bin/sh

mv /var/run/docker.sock /var/run/docker.sock.original

# use tcp port 8089 proxy the original socket
nohup socat TCP-LISTEN:8089,reuseaddr,fork UNIX-CONNECT:/var/run/docker.sock.original &

# use the new socket to proxy the 8089 port
nohup socat UNIX-LISTEN:/var/run/docker.sock,fork TCP-CONNECT:127.0.0.1:8089 &

nohup tcpdump -i lo 'port 8089 and (tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x504f5354)' -w /root/docker.sock.pacp &
