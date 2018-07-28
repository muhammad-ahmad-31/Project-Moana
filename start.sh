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



confg=attack.conf
touch $confg


function top1(){

	
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


function main_header {

clear
echo
echo
echo
sleep 0.07 && echo -e "$cyan "
sleep 0.07 && echo -e " ⌠▓▒▓▒◘    ⌠▓▒▓▒◘          ┌▓\   /▓┐     ◘▒▒◘      /▒/\▒\    ⌠◘▒    ▒    /▒/\▒\ "
sleep 0.07 && echo -e " ║▒_  ▓▒   │▒║  ▓          │▒ ▒ ▒ ▒|    ▓    ▓    │▓    ▓    │▓ ▓   ▓   │▒    ▒ "
sleep 0.07 && echo -e " ≡◙◙◙◙◘    ║◙▒▓▒◘          │▓  ▓  ▓|   ▒      ▒   │▒▓▒▒▓▒    │▒  ▒  ▒   │▓▒▓▓▒▓ "
sleep 0.07 && echo -e " ║▒        │▒▓__           │▒     ▒|    ▓    ▓    │▓    ▓    │▓   ▓ ▓   │▒    ▒ "
sleep 0.07 && echo -e " ⌡▓        ⌡▓   ▓  OJECT   │▓     ▓|     ◘▒▒◘     ⌡▒    ▒    ⌡▒    ▒◘   ⌡▓    ▓ "
sleep 0.07 && echo -e "¯       ¯¯¯              ¯¯¯       ¯¯¯   ¯¯¯¯  ¯¯¯        ¯¯¯        ¯¯¯        "
echo
sleep 0.07 && echo -e "                              CAPTIVE PORTAL" $transparent
echo
echo
sleep 0.7 && echo -e "                        Created by:"$green" MUHAMMAD AHMAD"$transparent
echo
echo
echo
sleep 1 && echo -e $yellow"Welcome to Project Moana Captive Portal. Your own Captive Portal creater..." $transparent
sleep 4
clear

}



chmod a+x decider.sh
chmod a+x new_conf.sh
chmod a+x start_attack.sh













function installdependences {
top1
echo -e $green"Updating your system..."$transparent
echo "Running apt-get update..."
sleep 1
clear
apt-get update
sleep 1
clear

if
apt-get update | grep 'Err'
[ $? == 0 ]; then
clear
echo "


"
echo "apt-get failed to update your system."
echo ""
echo "This may be due to NO internet connectivity. Make sure you have a stable internet connection."
echo  ""
echo "Failed to get the required packages. EXITING....."
sleep 3
clear
exit
else

sleep 1

fi		

		
	if ! hash airodump-ng 2>/dev/null; then
	             echo -e $green"Installing Aircrack-ng..."$transparent	
		apt-get install aircrack-ng
                     sleep 0.025
                     clear
	else
                     echo -e $green"Aircrack-ng already Installed..."$transparent
		     sleep 0.6
                     clear
	fi
	

	
	if ! hash awk 2>/dev/null; then
	             echo -e $green"Installing gawk..."$transparent	
           apt-get install gawk
                     sleep 0.025
                     clear		
	else
                     echo -e $green"gawk already Installed..."$transparent
		     sleep 0.6
                     clear
	fi
	

	
	

	
	if ! hash dhcpd 2>/dev/null; then
                     echo -e $green"Installing isc-dhcp-server..."$transparent
		apt-get install isc-dhcp-server
	             sleep 0.025
                     clear	
	else
                     echo -e $green"isc-dhcp-server already Installed..."$transparent
		     sleep 0.6
                     clear
	fi
	
	
	if ! hash hostapd 2>/dev/null; then
                    echo -e $green"Installing hostapd..."$transparent
		apt-get install hostapd
                    sleep 0.025
                    clear
		
	else
                    echo -e $green"Hostapd already Installed..."$transparent
	
                    sleep 0.6
                    clear
	fi
	

	
	if ! hash iwconfig 2>/dev/null; then
                    echo -e $green"Installing iwconfig..."$transparent
		apt-get install iwconfig
		    sleep 0.025
                    clear
	else
                    echo -e $green"iwconfig already Installed..."$transparent
		    sleep 0.6
                    clear
	fi
	


	if ! hash lighttpd 2>/dev/null; then
	            echo -e $green"Installing lighttpd..."	$transparent
           apt-get install lighttpd
		    sleep 0.025
                    clear
	else
                    echo -e $green"lighttpd already Installed..."$transparent
		    sleep 0.6
                    clear
	fi
	


	if ! hash macchanger 2>/dev/null; then
	            echo -e $green"Installing macchanger..." $transparent	
         apt-get install macchanger
		    sleep 0.025
                    clear
	else
                    echo -e $green"macchanger already Installed..."$transparent
	            sleep 0.6
                    clear
	fi
	


	if ! hash mdk3 2>/dev/null; then
		    echo -e $green"Installing mdk3..."$transparent
         apt-get install mdk3
                    sleep 0.025
                    clear
      
	else
                    echo -e $green"mdk3 already Installed..."$transparent
		    sleep 0.6
                    clear
	fi
	


	if ! [ -f /usr/bin/nmap ]; then
	           echo -e $green"Installing nmap..."$transparent	
        apt-get install nmap
	           sleep 0.025
                   clear	
	else
                   echo -e $green"nmap already Installed..."$transparent
		   sleep 0.6
                   clear
	fi
	

	
	

	if ! hash python 2>/dev/null; then
	           echo -e $green"Installing python..."	$transparent
          apt-get install python
	           sleep 0.025
                   clear	
	else
                   echo -e $green"python already Installed..."$transparent
		   sleep 0.6
                   clear
	fi
	

	
	

	if ! hash xterm 2>/dev/null; then
                   echo -e $green"Installing xterm..."$transparent
            apt-get install xterm 
	           sleep 0.025
                   clear	
	else
                   echo -e $green"xterm already Installed..."$transparent
		   sleep 0.6
                   clear
	fi
	


	if ! hash openssl 2>/dev/null; then
                   echo -e $green"Installing openssl..."$transparent
            apt-get install openssl
	           sleep 0.025
                   clear	
	else
                   echo -e $green"openssl already Installed..."$transparent
		   sleep 0.6
                   clear
	fi
	


        if ! hash rfkill 2>/dev/null; then
                   echo -e $green"Installing rfkill..."$transparent     
           apt-get install rfkill
                   sleep 0.025
                   clear  
        else
                   echo -e $green"rfkill already Installed..."$transparent
                   sleep 0.6
                   clear
        fi
       
      
        if ! hash iptables 2>/dev/null; then
                   echo -e $green"Installing iptables..."$transparent
                      
       apt-get install iptables
                   sleep 0.025
                   clear
        else
                   echo -e $green"iptables already Installed..."$transparent
                   sleep 0.6
                   clear
        fi  

         if ! hash php-cgi 2>/dev/null; then
                   echo -e $green"Installing php-cgi..."$transparent
                      
       apt-get install php-cgi
                   sleep 0.025
                   clear
        else
                   echo -e $green"php-cgi already Installed..."$transparent
                   sleep 0.6
                   clear
        fi  

}   





###############################################################################################

function checkdependences {
echo "


"
echo -e $yellow"Checking for dependences....."$transparent
echo "



"

	echo -ne "airmon-ng......."
	if ! hash airmon-ng 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "airodump-ng....."
	if ! hash airodump-ng 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "awk............."
	if ! hash awk 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025



	echo -ne "dhcpd..........."
	if ! hash dhcpd 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent" (isc-dhcp-server)"
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "hostapd........."
	if ! hash hostapd 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "iwconfig........"
	if ! hash iwconfig 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "lighttpd........"
	if ! hash lighttpd 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "macchanger......"
	if ! hash macchanger 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
	    echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "mdk3............"
	if ! hash mdk3 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1

	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "nmap............"
	if ! [ -f /usr/bin/nmap ]; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	
	
	echo -ne "python.........."
	if ! hash python 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	
	
	echo -ne "xterm..........."
	if ! hash xterm 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "openssl........."
	if ! hash openssl 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$transparent""
		exit=1
	else
		echo -e "\e[1;32mOK!"$transparent""
	fi
	sleep 0.025

	echo -ne "rfkill.........."
        if ! hash rfkill 2>/dev/null; then
                echo -e "\e[1;31mNot installed"$transparent""
                exit=1
        else
                echo -e "\e[1;32mOK!"$transparent""
        fi
        sleep 0.025

       echo -ne "iptables.........."
        if ! hash iptables 2>/dev/null; then
                echo -e "\e[1;31mNot installed"$transparent""
                exit=1
        else
                echo -e "\e[1;32mOK!"$transparent""
        fi
        sleep 0.025

         echo -ne "php-cgi.........."
        if ! hash php-cgi 2>/dev/null; then
                echo -e "\e[1;31mNot installed"$transparent""
                exit=1
        else
                echo -e "\e[1;32mOK!"$transparent""
        fi
        sleep 0.025
        

sleep 1
clear
	if [ "$exit" = "1" ]; then
       installdependences
	
	fi

	sleep 1
	
}



























############################################List interfaces
function list_interfaces {

List=`ls /sys/class/net/ | grep -v "lo" `
set -- $List

interface1=$1
interface2=$2
interface3=$3
interface4=$4
interface5=$5

}

                                                   
#######################################Chose ap interface
function choose_ap_inter {
top1
echo -e $yellow"The available interfaces are:" $transparent
echo ""
airmon-ng
#echo ""
echo -e $green"Select a interface for Access Point:"$transparent  
echo -e $blue "1-"$transparent " $interface1"
echo -e $blue "2-"$transparent " $interface2"
echo -e $blue "3-"$transparent " $interface3"
echo -e $blue "4-"$transparent " $interface4"
echo -e $blue "5-"$transparent " $interface5"

read -p ">>> " n
case $n in
    1) ap_inter=$interface1;;
    2) ap_inter=$interface2;;
    3) ap_inter=$interface3;;
    4) ap_inter=$interface4;;
    5) ap_inter=$interface5;;
    *) echo "invalid option";;
esac

}



#Check ap_inter
function check_ap_inter {
if [ -z "$ap_inter" ]
then
      echo -e $red"You haven't selected a valid interface. Try again" $transparent
       choose_ap_inter
       check_ap_inter
else
      echo "$ap_inter interface selected for AP."
fi
clear
}

#######################################Chose deauth inter

function choose_deauth_inter {
airmon-ng
echo "
"
echo -e $green"Select a interface for Deauthentication (Optional)"$transparent
echo ""
echo "To use to deauthenticate real AP"
echo ""
echo "Press ENTER to skip"
echo ""
echo -e $blue "1-"$transparent " $interface1"
echo -e $blue "2-"$transparent " $interface2"
echo -e $blue "3-"$transparent " $interface3"
echo -e $blue "4-"$transparent " $interface4"
echo -e $blue "5-"$transparent " $interface5"

read -p ">>> " n
case $n in

    1) deauth_inter=$interface1;;
    2) deauth_inter=$interface2;;
    3) deauth_inter=$interface3;;
    4) deauth_inter=$interface4;;
    5) deauth_inter=$interface5;;
    *) echo "No interface selected"
      unset_deauth_inter;;
esac
clear
}

############################################Final chcking
function final_option { 
top1
echo "
"
echo "Interfaces are:
$ap_inter
$deauth_inter
"
echo "

"
shouldloop=true;
while $shouldloop; do

echo -e $green"Do you want to change the interfaces? [y/n]:$transparent " 
read -p ">>> " delconf
shouldloop=false;
if [ $delconf == 'y' ]; then
  unset_deauth_inter
   choose_ap_inter
   check_ap_inter
   choose_deauth_inter
   final_option
  
elif [ $delconf == 'n' ]; then
   echo "Your interfaces have been selected"
else
   echo -e $red"Enter a valid response Y or n"$transparent;
   shouldloop=true;
fi
done
clear
}

function unset_deauth_inter {
unset deauth_inter 
}
###########################################Check if same
function check_if_same {
echo "Checking if your interfaces for AP and deauthenticating are same.
When they are same they don't work properly."

if [ "$ap_inter" == "$deauth_inter" ];then
echo -e $red"Your interfaces are same. Choose different ones."
sleep 0.5
unset_deauth_inter
final_option
check_if_same
else

sleep 0.5
echo "Interfaces are different..We are good to go"
echo "

"
fi

}

##########################################Enable Monitor




function ap_inter_mon {

echo "Enabling monitor mode"
ifconfig $ap_inter down
iwconfig $ap_inter mode monitor
ifconfig $ap_inter up
echo "Monitor mode enabled on $ap_inter."
sleep 1
}

function deauth_inter_mon {
ifconfig $deauth_inter down
iwconfig $deauth_inter mode monitor
ifconfig $deauth_inter up
echo "Monitor mode enabled on $deauth_inter."
sleep 1
}
#################################Check if deauth availabe

####################################Disable monitor
#Disable ap_intermon


#######################check if found deauth then enable monior
function check_enable_deauth_intermon {
if [ -z "$deauth_inter" ]
then
      echo -e $red"You haven't selected a Deauthenticating interface. So can't enable monitor mode."$transparent
else
      deauth_inter_mon
fi
}


#####################Check if found deauth then disble monitor



clear




verr1=`awk '{if(NR==1) print $0}' $confg` 2>/dev/null
verr2=`awk '{if(NR==2) print $0}' $confg` 2>/dev/null
verr3=`awk '{if(NR==3) print $0}' $confg` 2>/dev/null
verr4=`awk '{if(NR==4) print $0}' $confg` 2>/dev/null
verr5=`awk '{if(NR==5) print $0}' $confg` 2>/dev/null

function new_inter_in_conf {

nus1="$ap_inter"
nus2="$deauth_inter"


echo "$nus1
$verr2
$verr3
$verr4
$nus2" >"$confg"
}

main_header
checkdependences


list_interfaces
choose_ap_inter
check_ap_inter
choose_deauth_inter
final_option
check_if_same
rfkill unblock all
ap_inter_mon
check_enable_deauth_intermon
new_inter_in_conf

clear
sleep 2

./decider.sh































