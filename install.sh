#!/bin/bash
# Script cek user login OpenVPN
# Script Mod By GUgun09

cd /usr/bin
wget -O premium.tar.gz "https://raw.githubusercontent.com/gugun09/cekVPN/master/premium.tar.gz"
tar -xvf premium.tar.gz
rm -f premium.tar.gz

chmod +x cekvpn
chmod +x renew
chmod +x cekpass

cd

# colored text
apt-get -y install ruby
gem install lolcat

cd
rm -f /root/install.sh
