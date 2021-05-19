#!/usr/bin/env bash

# 1. Kernel Version
#TODO

cd ..

# 2. Golang version

# # TODO if comprobacion
# sudo rm -rf /usr/local/go
# cd ..
# wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
# sudo tar -C /usr/local -zxvf go1.14.4.linux-amd64.tar.gz
# mkdir -p ~/go/{bin,pkg,src}
# # The following assume that your shell is bash
# echo 'export GOPATH=$HOME/go' >> ~/.bashrc
# echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
# echo 'export PATH=$PATH:$GOPATH/bin:$GOROOT/bin' >> ~/.bashrc
# echo 'export GO111MODULE=auto' >> ~/.bashrc
# # source ~/.bashrc


# 3. Control plane suporting packages

sudo apt -y update
sudo apt -y install mongodb wget git
sudo systemctl start mongodb

# 4. User-plane Supporting Packages

sudo apt -y update
sudo apt -y install git gcc g++ cmake autoconf libtool pkg-config libmnl-dev libyaml-dev
go get -u github.com/sirupsen/logrus
#sudo apt-get update && sudo apt-get install build-essential


# 5. Linux Host Network Settings
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o enp3s0 -j MASQUERADE
sudo iptables -A FORWARD -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1400
sudo systemctl stop ufw
sudo iptables -I FORWARD 1 -j ACCEPT


# 6. Packages for webconsole

sudo apt remove cmdtest
sudo apt remove yarn

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -y nodejs yarn

# 7. Instalat gtp para plano de datos
git clone -b v0.2.1 https://github.com/PrinzOwO/gtp5g.git
cd gtp5g
make
sudo make install
cd ..