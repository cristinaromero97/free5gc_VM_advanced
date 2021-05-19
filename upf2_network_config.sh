#!/usr/bin/env bash

sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o enp3s0 -j MASQUERADE
sudo systemctl stop ufw
sudo iptables -I FORWARD 1 -j ACCEPT

sudo iptables -t nat -A POSTROUTING -s 60.62.0.0/16 ! -o upfgtp -j MASQUERADE