#!/bin/bash
# Modified by Gugun

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
if [ -f /etc/debian_version ]; then
  UIDN=1000
elif [ -f /etc/redhat-release ]; then
  UIDN=500
else
  UIDN=500
fi

echo " "
echo " "
echo "===========================================" | lolcat
echo " "
echo "-----------------------------------" | lolcat
echo "        USER ACCOUNTS LIST         " | lolcat
echo "-----------------------------------" | lolcat
echo "[USERNAME]   -   [DATE EXPIRED]  " | lolcat
echo " "
while read ceklist
do
        AKUN="$(echo $ceklist | cut -d: -f1)"
        ID="$(echo $ceklist | grep -v nobody | cut -d: -f3)"
        exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
        if [[ $ID -ge $UIDN ]]; then
        printf "%-17s %2s\n" "$AKUN" "$exp" | lolcat
        fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= '$UIDN' && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo "-------------------------------------" | lolcat
echo "Number Of User Accounts: $JUMLAH USERS" | lolcat
echo "-------------------------------------" | lolcat
echo " "
echo "===========================================" | lolcat
read -p "Iput Username to Renew  : " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "How many days to extend?: " masa_aktif

today=`date +%s`
masa_aktif_detik=$(( $masa_aktif * 86400 ))
saat_expired=$(($today + $masa_aktif_detik))
tanggal_expired=$(date -u --date="1970-01-01 $saat_expired sec GMT" +%Y/%m/%d)
tanggal_expired_display=$(date -u --date="1970-01-01 $saat_expired sec GMT" '+%d %B %Y')
clear
echo "Connecting to Server..."
sleep 0.5
echo "Adding time..."
sleep 0.5
passwd -u $username
usermod -e  $tanggal_expired $username
  egrep "^$username" /etc/passwd >/dev/null
  echo -e "$password\n$password" | passwd $username
  clear
  echo " "
  echo " "
  echo "---------------------------------------" | lolcat
  echo "       Extended Account Details        " | lolcat
  echo "---------------------------------------" | lolcat
  echo "   Username        : $username" | lolcat
  echo "   Active Time     : $masa_aktif Days" | lolcat
  echo "   Date Expired    : $tanggal_expired_display" | lolcat
  echo "--------------------------------------" | lolcat
  echo " "

else
echo -e "Username ${red}$username${NC} not found in your VPS" | lolcat
exit 0
fi
