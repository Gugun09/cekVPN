#!/bin/bash
# Script cek user login OpenVPN
# Script Mod By GUgun09

cd /usr/bin
wget -O vpn "https://raw.githubusercontent.com/gugun09/cekVPN/master/cekVPN.sh"
wget -O renew "https://raw.githubusercontent.com/gugun09/cekVPN/master/renew.sh"
chmod +x vpn
chmod +x renew

cd

# colored text
apt-get -y install ruby
gem install lolcat

cd
rm -f /root/install.sh
