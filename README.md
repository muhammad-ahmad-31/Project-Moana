

Written by Muhammad Ahmad

# Introduction:

This tool creates a Captive portal which grabs the credentials from the clients connected. A hotspot is created using HOSTAPD, a dhcp server using ics-dhcp-server, DNS spoofer to redirect traffic to login page, grabbed from google and different sources, mdk3 as deauthenticator.

It shows Clients connected their names, ips assigned and macs.
An identifier prints the result to the screen and also writes it in /root/Project-Moana-Input.log

 
# Selection of interfaces:

I recommend to use two different interfaces for attack. One to Create fake AP and other to deauthenticate the clients from real AP. It doesn't run the both processes on the same interface. If both are same they won't work properly.


# Options:

There are three options in it:

1) RESTORE:  It restores the previous configuration, thus reduces the time to target the same network.
2) MANUAL:  It gives you the manual option to enter the name, mac and channel of AP. Useful when making your own Captive Portal with custom settings or Airodump-ng isn't picking up the network.
3) NEW:  It scans for available networks by Airodump-ng and copies the details of the selected AP.



# START:

Worked perfectly fine with Kali 2018, just needs to install some dependencies which require an internet connnection.

Just run (Do not try to open other scripts individually, they work with coordination, if run they may delete your data)
chmod +x start.sh
./start.sh


# ERRORS:

If login page doesn't show up, then it may be apache2 webserver interfaring.

If your wifi doesn't connect to the network after using this, then it may be your network-manager isn't started. Try

 service network-manager start

It doesn't change the mac after attack with deauthenticating, you may want to change it manually. Was lazy to add this.





Well this is my first script. I'm not a pro nor posesses the complete knowledge of any programming language. Just had this idea, googled everything and came up with this script to ease myself in learning more about captive portals. 
I am thinking of enhancing it, giving more options etc. It will be updated.
Tutorials of it will be posted on Youtube to make it easier to use.

THIS IS PURELY FOR EDUCATIONAL PURPOSES. TRY THIS AT YOUR OWN RISK. IT IS NOT INTENDED TO CAUSE ANY HARM TO ANYONE.


