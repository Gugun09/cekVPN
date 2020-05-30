#!/bin/bash
# Script cek user login OpenVPN
# Script Mod By GUgun09

cd /usr/bin
wget -O vpn "https://raw.githubusercontent.com/gugun09/cekVPN/master/cekVPN.sh"
chmod +x vpn

cd

# colored text
apt-get -y install ruby
gem install lolcat

cd
rm -f /root/install.sh
