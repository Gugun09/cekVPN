#!/bin/bash

clear
flag=0

echo

function expired_users(){
echo "                      _\|/_      "
echo "                      (o o)      "
echo "-------------------o00-{_}-00o---"
echo "BIL  USERNAME          EXPIRED "
echo "---------------------------------"
count=1
	cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
	totalaccounts=`cat /tmp/expirelist.txt | wc -l`
	for((i=1; i<=$totalaccounts; i++ )); do
	tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
		username=`echo $tuserval | cut -f1 -d:`
		userexp=`echo $tuserval | cut -f2 -d:`
		userexpireinseconds=$(( $userexp * 86400 ))
		todaystime=`date +%s`
		expired="$(chage -l $username | grep "Account expires" | awk -F": " '{print $2}')"
		if [ $userexpireinseconds -lt $todaystime ] ; then
			printf "%-4s %-15s %-10s %-3s\n" "$count." "$username" "$expired"
			count=$((count+1))
		fi
	done
	rm /tmp/expirelist.txt
}

function not_expired_users(){
    cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
    totalaccounts=`cat /tmp/expirelist.txt | wc -l`
    for((i=1; i<=$totalaccounts; i++ )); do
        tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
        username=`echo $tuserval | cut -f1 -d:`
        userexp=`echo $tuserval | cut -f2 -d:`
        userexpireinseconds=$(( $userexp * 86400 ))
        todaystime=`date +%s`
        if [ $userexpireinseconds -gt $todaystime ] ; then
            echo $username
        fi
    done
	rm /tmp/expirelist.txt
}

function monssh2(){
echo ""
echo "|   Tgl-Jam    | PID   |   User Name  |      Dari IP      |"
echo "-------------------------------------------------------------"
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);

echo "=================[ Checking Dropbear login ]================="
echo "-------------------------------------------------------------"
for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $12}'`;
	waktu=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $1,$2,$3}'`;
	if [ $NUM -eq 1 ]; then
		echo "$waktu - $PID - $USER - $IP";
	fi
done


echo "-------------------------------------------------------------"
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

echo "==================[ Checking OpenSSH login ]================="
echo "-------------------------------------------------------------"
for PID in "${data[@]}"
do
        #echo "check $PID";
		NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
		USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
		IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
		waktu=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $1,$2,$3}'`;
        if [ $NUM -eq 1 ]; then
                echo "$waktu - $PID - $USER - $IP";
        fi
done

echo "-------------------------------------------------------------"
echo -e "==============[ User Monitor Dropbear & OpenSSH]============="
}



echo "                       ----[SELAMAT DATANG ]---" | lolcat
echo "        =====================================================" | lolcat
echo "        #           WhatsApp     : 081357879215             #" | lolcat
echo "        #                                                   #" | lolcat
echo "        #           Facebook     : fb.com/Nanda.convenat    #" | lolcat
echo "        #                                                   #" | lolcat
echo "        #                                                   #" | lolcat
echo "        #          Copyright ©  Nanda Gunawan  2020         #" | lolcat
echo "        =====================================================" | lolcat
date +"                    %A, %d-%m-%Y" | lolcat
date +"                    %H:%M:%S %Z" | lolcat
echo ""
PS3='Silahkan ketik nomor pilihan anda lalu tekan ENTER: ' 
options=("Cek Status Memory" "Monitor User Login" "Hapus Cache Memory" "User Sudah Kadaluarsa" "User Belum Kadaluarsa" "Perbarui User" "Perbarui Password User" "Cek User Openvpn" "Aktifkan Kill Multi Login" "Matikan Kill Multi Login" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Cek Status Memory")
       clear
       free -h | lolcat
	    break
            ;;
	"Monitor User Login")
	clear
	monssh2
	break
	;;
	"Hapus Cache Memory")
	clear
	 echo "Sebelum..." | lolcat
		        free -h | lolcat
	                echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a
			echo ""
			echo "Sesudah..." | lolcat
			free -h | lolcat
			echo "SUKSES..!!!Cache ram anda sudah di bersihkan." | lolcat
	break
	;;
	"User Sudah Kadaluarsa")
	clear
	expired_users
	break
	;;
	"User Belum Kadaluarsa")
	clear
	not_expired_users
	break
	;;
	"Perbarui User")
	renew
	break
	;;
	"Perbarui Password User")
	clear
	cekpass
	break
	;;
	"Cek User Openvpn")
	clear
	cekvpn
	break
	;;
	"Aktifkan Kill Multi Login")
	   #echo "@reboot root /root/userlimit.sh" > /etc/cron.d/userlimitreboot
	   echo "* * * * * root ./userlimit.sh 2" > /etc/cron.d/userlimit1
	   echo "* * * * * root sleep 10; ./userlimit.sh 2" > /etc/cron.d/userlimit2
           echo "* * * * * root sleep 20; ./userlimit.sh 2" > /etc/cron.d/userlimit3
           echo "* * * * * root sleep 30; ./userlimit.sh 2" > /etc/cron.d/userlimit4
           echo "* * * * * root sleep 40; ./userlimit.sh 2" > /etc/cron.d/userlimit5
           echo "* * * * * root sleep 50; ./userlimit.sh 2" > /etc/cron.d/userlimit6
	   #echo "@reboot root /root/userlimitssh.sh" >> /etc/cron.d/userlimitreboot
	   echo "* * * * * root ./userlimitssh.sh 2" >> /etc/cron.d/userlimit1
	   echo "* * * * * root sleep 11; ./userlimitssh.sh 2" >> /etc/cron.d/userlimit2
           echo "* * * * * root sleep 21; ./userlimitssh.sh 2" >> /etc/cron.d/userlimit3
           echo "* * * * * root sleep 31; ./userlimitssh.sh 2" >> /etc/cron.d/userlimit4
           echo "* * * * * root sleep 41; ./userlimitssh.sh 2" >> /etc/cron.d/userlimit5
           echo "* * * * * root sleep 51; ./userlimitssh.sh 2" >> /etc/cron.d/userlimit6
	    service cron restart
	    service ssh restart
	    service dropbear restart
	    echo "------------+ AUTO KILL SUDAH DI AKTIFKAN BOSS +--------------" | lolcat
	    
	echo "Dasar pelit!!! user ente marah2 jangan salahkan ane ya boss
	nanti jangan lupa di matikan boss" | lolcat
		break
		;;
	"Matikan Kill Multi Login")
	rm -rf /etc/cron.d/userlimit1
	rm -rf /etc/cron.d/userlimit2
	rm -rf /etc/cron.d/userlimit3
	rm -rf /etc/cron.d/userlimit4
	rm -rf /etc/cron.d/userlimit5
	rm -rf /etc/cron.d/userlimit6
	rm -rf /etc/cron.d/userlimitreboot
	service cron restart
	    service ssh restart
	    service dropbear restart
	echo "AUTO KILL LOGIN,SUDAH SAYA MATIKAN BOS!!!" | Lolcat
	break
	;;
		"Quit")

		break
	;;
*) echo Angka yang anda masukkan invalid;
esac
done
