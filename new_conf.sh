#/bin/bash

white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"
transparent="\e[0m"


function top1(){

	echo
	echo -e "   $blue\e[5m/~$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$~"'\'
	echo -e "   $blue| $                                                                    $ |\e[25m"
  echo -e "   $blue\e[5m| $\e[25m"$green"                  Project-Moana  " "${red}C""${green}a""${yellow}p""${red}t""${green}i""${yellow}v""${red}e" "${green}P""${yellow}o""${red}r""${green}t""${yellow}a""${red}l"            $blue"                   \e[5m$ |\e[25m"
        echo -e "   $blue\e[5m| $                                                                    $ |\e[25m"
        echo -e "   $blue\e[5m| $                  \e[25m ""Created by:" $Cafe"Muhammad Ahmad"$blue"\e[5m                       $ |\e[25m"
	echo -e "   $blue\e[5m| $                                                                    $ |"
	echo -e "   $blue\~$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$~/\e[25m""$transparent"
	echo
	echo

}


confg=attack.conf

ap_inter=`awk '{if(NR==1) print $0}' $confg`		
deauth_inter=`awk '{if(NR==5) print $0}' $confg`

function start_network_manager {
  if ! systemctl status network-manager.service &> /dev/null; then
    systemctl start network-manager.service
   echo "Started network manager."
fi
}

function stop_network_manager {
  if systemctl status network-manager.service &> /dev/null; then
    systemctl stop network-manager.service
  echo "Stoping network manager"
  fi
}



################################################333
top1
echo ""

echo -e $yellow"Now you will select the configuration of Captive Portal AP by scanning for a target Access Point." $transparent
echo ""
echo "It will scan for available networks using Airodump-ng and will select the details of the the selected AP."
echo "
"
function inter_for_scan {
echo "
"
sleep 1
echo -e $green "Select an interface to scan for available networks."


echo -e $blue" 1-" $transparent " $ap_inter"
echo -e $blue" 2-" $transparent " $deauth_inter"

read -p ">>> " n
case $n in
    1) scan_inter=$ap_inter;;
    2) scan_inter=$deauth_inter;; 
    *) invalid option;;
esac
clear
}




############################################Airodump-ng scan
function get_target_details {
echo "Close the Xterm window after 5 seconds the desired network appears."
stop_network_manager
sudo xterm -e airodump-ng --encrypt WPA -w m --output-format csv -a $scan_inter --ignore-negative-one
start_network_manager
sleep 1
clear
List=`cat m-01.csv | grep -v "channel," |sed '/Station MAC/,$d' | awk -F , '{print $1,$4,$14}'| awk '{print $1,$2,$3}'`



arr=($List)


#target macs
mac1=${arr[1]}
mac2=${arr[4]}
mac3=${arr[7]}
mac4=${arr[10]}
mac5=${arr[13]}
mac6=${arr[16]}
mac7=${arr[19]}
mac8=${arr[22]}
mac9=${arr[25]}
mac10=${arr[28]}
#Channels
ch1=${arr[2]}
ch2=${arr[5]}
ch3=${arr[8]}
ch4=${arr[11]}
ch5=${arr[14]}
ch6=${arr[17]}
ch7=${arr[20]}
ch8=${arr[23]}
ch9=${arr[26]}
ch10=${arr[29]}
#ch4=${arr[11]}
#ch4=${arr[11]}

#Names
name1=${arr[3]}
name2=${arr[6]}
name3=${arr[9]}
name4=${arr[12]}
name5=${arr[15]}
name6=${arr[18]}
name7=${arr[21]}
name8=${arr[24]}
name9=${arr[27]}
name10=${arr[30]}
#name4=${arr[12]}
#name10="hello"

#'{printf("%010d %s\n", NR, $0)}
echo "



"
echo -e $green"        MAC ADDRESS     CHANNEL      ESSID" $transparent
echo -e "======================================================" $transparent

echo -e $blue "1-"$transparent "  $mac1     $ch1         $name1"$transparent
echo -e $blue "2-"$transparent "  $mac2     $ch2         $name2"$transparent
echo -e $blue "3-"$transparent "  $mac3     $ch3         $name3"$transparent
echo -e $blue "4-"$transparent "  $mac4     $ch4         $name4"$transparent
echo -e $blue "5-"$transparent "  $mac5     $ch5         $name5"$transparent
echo -e $blue "6-"$transparent "  $mac6     $ch6         $name6"$transparent
echo -e $blue "7-"$transparent "  $mac7     $ch7         $name7"$transparent
echo -e $blue "8-"$transparent "  $mac8     $ch8         $name8"$transparent
echo -e $blue "9-"$transparent "  $mac9     $ch9         $name9"$transparent
echo -e $blue "10-"$transparent "  $mac10    $ch10        $name10"$transparent

echo "

"
echo -e $green"Enter number on which network is located" $transparent
echo "
"
read -p ">>> " n
case $n in
    1) target_mac=$mac1
       target_ch=$ch1
       target_name=$name1;;
    2) target_mac=$mac2
       target_ch=$ch2
       target_name=$name2;;
    3) target_mac=$mac3
       target_ch=$ch3
       target_name=$name3;;
    4) target_mac=$mac4
       target_ch=$ch4
       target_name=$name4;;
    5) target_mac=$mac5
       target_ch=$ch5
       target_name=$name5;;
    6) target_mac=$mac6
       target_ch=$ch6
       target_name=$name6;;
    7) target_mac=$mac7
       target_ch=$ch7
       target_name=$name7;;
    8) target_mac=$mac8
       target_ch=$ch8
       target_name=$name8;;
    9) target_mac=$mac9
       target_ch=$ch9
       target_name=$name9;;
    10) target_mac=$mac10
       target_ch=$ch10
       target_name=$name10;;
    *) invalid option;;
esac
}
#echo $target_mac
#echo $target_ch
#echo $target_name

###########
function networks_list_dump {
echo "Deleting dump file."
rm -f m-01.csv
}
###############################################################ENTER name again
function Enter_name {
clear
top1
echo "

"
echo -e $green"Enter the name of target AP again. (Copy paste will be handy)" $transparent
sleep 1
cat m-01.csv | grep -v "channel," |sed '/Station MAC/,$d' | awk -F "," '{print $1,$4,$14}'
echo "
"
read -p "Enter name:  " ap_name1

}






function match_target_name {
clear
top1
echo "


"
if
cat m-01.csv | grep -v "channel," |sed '/Station MAC/,$d' | awk -F "," '{print $1,$4,$14}' | grep "\<$ap_name1\>"
[ $? == 0 ]
then
echo -e $yellow"Target name has been verified" $transparent
else
echo -e $red"Target name cannot be found in the list. Try again" $transparent
Enter_name
match_target_name

fi
}





function check_ap_name {
echo "



"
shouldloop=true;
while $shouldloop; do
echo -e $green "Do you want the name of Captive Portal exact to the target network then press [y]. If you want to change the name manually than enter [n] [y/n]: " $transparent
echo "
"
read -p ">>> " delconf1
shouldloop=false;
if [ $delconf1 == 'y' ]; then
match_target_name
  
elif [ $delconf1 == 'n' ]; then
   Enter_name
else
echo "

"
   echo -e $red"Enter a valid response Y or n"$transparent;
   shouldloop=true;
fi
done
}

function wrt_new_conf {
echo "$ap_inter
$ap_name1
$target_mac
$target_ch
$deauth_inter
" >"$confg"
}

function dis_ap_inter_mon {

ifconfig $ap_inter down
iwconfig $ap_inter mode managed
ifconfig $ap_inter up
echo "Monitor mode disabled on $ap_inter."
}

#disable deauth inter mon

function dis_deauth_inter_mon {
ifconfig $deauth_inter down
iwconfig $deauth_inter mode managed
ifconfig $deauth_inter up
echo "Monitor mode disabled on $deauth_inter."
}


function check_disable_deauth_intermon {
if [ -z "$deauth_inter" ]
then
      echo "You haven't selected a Deauthenticating interface. So can't disable monitor mode."
else
      dis_deauth_inter_mon
fi
}

function clean_mess {
clear
top1
echo ""
echo -e $red"Cleaning Mess..." $transparent
echo ""
dis_ap_inter_mon
check_disable_deauth_intermon
networks_list_dump
exit
}
# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        clean_mess
}



inter_for_scan
get_target_details
Enter_name 
match_target_name
check_ap_name
networks_list_dump
wrt_new_conf

sleep 2
clear

top1
echo "
"
echo "The new configuration is as:"
cat $confg
echo "
"
echo "Press ENTER to continue with the above configuration OR Ctrl-C to exit and alter the configuration again"

read -p ""
clear

./start_attack.sh












