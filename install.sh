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

# setting banner
rm /etc/issue.net
wget -O /etc/issue.net "https://raw.githubusercontent.com/gugun09/premscript/master/issue.net"
sed -i 's@#Banner@Banner@g' /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear
service ssh restart
service dropbear restart

cd
rm -f /root/install.sh
