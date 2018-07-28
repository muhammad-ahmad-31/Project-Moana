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

#############################Cr


varr1=`awk '{if(NR==1) print $0}' $confg`
varr2=`awk '{if(NR==2) print $0}' $confg`
varr3=`awk '{if(NR==3) print $0}' $confg`
varr4=`awk '{if(NR==4) print $0}' $confg`
varr5=`awk '{if(NR==5) print $0}' $confg`



#Edit config

function enter_new_name {
top1
echo "
"
echo -e $green"Enter the name of AP:" $transparent " ( previously:  $varr2 )"
read -p ">> " neww2

if [ -z $neww2 ]; then
   echo -e $red"You haven't entered a value. Try again" $transparent
 enter_new_name
else
   sleep 0.2
fi
}

 


function enter_new_mac {
echo "
"
echo -e $green"Enter the MAC of the AP:"$transparent " ( previously:  $varr3 )"
read -p ">> " neww3

if [ -z $neww3 ]; then
  echo -e $red"You haven't entered a value. Try again" $transparent
enter_new_mac
else
  sleep 0.2
fi
}

function enter_new_ch { 
echo "
"
echo -e $green"Enter the Channel number of AP:" $transparent" ( previously:  $varr4 )"
read -p ">> " neww4

if [ -z $neww4 ]; then
   echo -e $red"You haven't entered a value. Try again" $transparent
enter_new_ch
else
   sleep 0.2
fi
}





function final_check {
echo "


"
shouldloop=true;
while $shouldloop; do
echo -e $green"Do you want to change the configuration file again? [y/n]: "$transparent
read -p ">>> " delconf4
shouldloop=false;
if [ $delconf4 == 'y' ]; then
   clear
  enter_new_name
   enter_new_mac
   enter_new_ch
   final_check
    
elif [ $delconf4 == 'n' ]; then
   echo "$varr1
$neww2
$neww3
$neww4
$varr5" >"$confg"
./start_attack.sh

else
   echo -e $red"Enter a valid response Y or n"$transparent;
   shouldloop=true;
fi
done
}


function manual {
clear
top1
echo ""
echo "The previous configuration is as follows:"
echo "
"
echo -e $yellow"AP interface ="  $transparent"   $varr1"
sleep 0.2
echo -e $yellow"AP Name ="$transparent  "   $varr2"
sleep 0.2
echo -e $yellow"AP Mac =" $transparent "   $varr3"
sleep 0.2
echo -e $yellow"Ap Channel =" $transparent "   $varr4"
sleep 0.2
echo -e $yellow"Deauthenticating interface ="$transparent  "   $varr5"
echo "


"

shouldloop=true;
while $shouldloop; do
echo -e $green"Do you want to change the configuration? [y/n]: " $transparent
read -p ">>> " delconf3
shouldloop=false;
if [ $delconf3 == 'y' ]; then
  clear
   enter_new_name
   enter_new_mac
   enter_new_ch
   final_check
  
elif [ $delconf3 == 'n' ]; then
   echo "Your attack with same conf will commence."
   ./start_attack.sh
else
   echo -e $red"Enter a valid response Y or n"$transparent;
   shouldloop=true;
fi
done
}



function restore_conf {
echo -e $yellow"AP interface ="  $transparent"   $varr1"
sleep 0.5
echo -e $yellow"AP Name ="$transparent  "   $varr2"
sleep 0.5
echo -e $yellow"AP Mac =" $transparent "   $varr3"
sleep 0.5
echo -e $yellow"Ap Channel =" $transparent "   $varr4"
sleep 0.5
echo -e $yellow"Deauthenticating interface ="$transparent  "   $varr5"

sleep 2
clear

./start_attack.sh

}


function options_menu {
top1

echo -e $yellow"Here you have to select an option to how to create the Captive Portal." $transparent
echo ""
echo -e $blue"Restore previous configuration:"$transparent   "   It will create the Captive Portal with already defined configuration i.e (Name,channel,Mac)."
echo ""
echo -e $blue"Manual Configuration:"$transparent   "   You have to configuration manually."
echo ""
echo -e $blue"New Configuration:"$transparent   "   It will create new configuration by searching for Target network. $red\e[5m(Note: Run this at first time.)\e[25m$transparent"
echo ""
echo -e $green"Select an option"$transparent
echo ""
echo -e $blue"1)"$transparent  "  Restore previous configuration"
echo -e $blue"2)"$transparent  "  Manual configuration"
echo -e $blue"3)"$transparent  "  New Configuration"
read -p ">>>  " menu


if [ $menu == '1' ]; then
   restore_conf
elif [ $menu == '2' ]; then
   manual

elif [ $menu == '3' ]; then
  clear
  ./new_conf.sh
fi
}



function dis_ap_inter_mon1 {

ifconfig $varr1 down
iwconfig $varr1 mode managed
ifconfig $varr1 up
echo "Monitor mode disabled on $varr1."
}

#disable deauth inter mon

function dis_deauth_inter_mon {
ifconfig $varr5 down
iwconfig $varr5 mode managed
ifconfig $varr5 up
echo "Monitor mode disabled on $varr5."
}


function check_disable_deauth_intermon1 {
if [ -z "$varr5" ]
then
      echo "You haven't selected a Deauthenticating interface. So can't disable monitor mode."
else
      dis_deauth_inter_mon
fi
}

function clean_shit {

clear

top1
echo ""
echo -e $red"Cleaning Mess..." $transparent
echo ""
dis_ap_inter_mon1
check_disable_deauth_intermon1
sleep 1
clear
exit
}
# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        clean_shit
}





options_menu














