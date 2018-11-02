#!/bin/bash

### Installation steps:
### Clone Project from GitHub
##  	git clone https://github.com/jerrywthompson/garagebuddy.git && cd garagebuddy && sudo apt-get -y install expect
### Update the oonfig file located here:   /home/pi/garagebuddy/garagebuddy.config
### Install expect with the following commnad
## 		sudo apt-get -y install expect
### Run the install script from /home/pi/garagebuddy Note: script is inside of /tools but run from garagebuddy directory
##  	unbuffer bash tools/installGarageBuddy.sh 2>&1 | tee garageBuddyInstall.log
#### NOTE:  Runtime logs are stored here:  tail -f /var/log/pi_garage_alert.log


echo "********** Script started *********"

# Update Raspbian
echo "Updating the Raspbian image"
echo $PWD
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade


# Install core apps
echo "Installng python and other core applications "
sudo apt-get -y install python-setuptools python-dev libffi-dev libssl-dev
sudo pip install -U Requests


# Install and configure the alert
echo "***** Begin installng the GarageBuddy alert *****"
# get config items
echo "***** Getting config items from file located here: /home/pi/garagebuddy/garagebuddy.config ***** "
source garagebuddy.config

echo "***** Copy files and folders from /home/pi/garagebuddy/pi_garage_alert to permanent locations *****"
echo "***** First change locations to: /home/pi/garagebuddy/pi_garage_alert *****"
cd pi_garage_alert
echo $PWD
sudo cp bin/pi_garage_alert.py /usr/local/sbin/
sudo cp etc/pi_garage_alert_config.py /usr/local/etc/
sudo cp init.d/pi_garage_alert /etc/init.d/
sudo chown pi /usr/local/etc/pi_garage_alert_config.py
sudo apt-get clean


sudo debconf-set-selections <<< "raspberrypi"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get -y install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules
echo "Updating /ect/postfix/main.cf"
sudo sed -i -e 's/relayhost=/\
# Setup email smtp server for GarageBuddy\
relayhost = [smtp.gmail.com]:587\
smtp_sasl_auth_enable = yes\
smtp_sasl_password_maps = hash:\/etc\/postfix\/sasl_passwd\
smtp_sasl_security_options = noanonymous\
smtp_tls_CAfile = \/etc\/ssl\/certs\/ca-certificates.crt\
smtp_use_tls = yes\
/g' /etc/postfix/main.cf 


# Create & modify file sasl_passwd
sudo touch /etc/postfix/sasl_passwd
sudo chmod 777 /etc/postfix/sasl_passwd
sudo echo $gmailPassword >> /etc/postfix/sasl_passwd
sudo chmod 400 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd


# Add phone phone numbers for text alerting
echo "Adding mobile phone numbers for text alerts"

echo "emailAddresses: "
echo $emailAddresses


# Configure for each active garage door
echo "Modify the pi_garage_alert_config.py for each active garage door"
if [ $garageDoor1 = "active" ]; 
	then
		echo "Garage door 1 is active.  Updating config file for garage door 1"
		#sudo sed -i -e 's/emailAddressHere/'"'"'email:123456789@messaging.sprintpcs.com'"'"', '"'"'email:123456789@tmomail.net'"'"'/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/$garageDoor1CommentCode//g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor1Name/$garageDoor1Name/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor1Pin/$garageDoor1Pin/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor1AlertEmailAddress1/$emailAddresses/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor1AlarmOpenTimeOpen1/$garageDoor1AlarmOpenTimeOpen1/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor1AlertEmailAddress2/$emailAddresses/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor1AlarmOpenTimeOpen2/$garageDoor1AlarmOpenTimeOpen2/g" /usr/local/etc/pi_garage_alert_config.py
	else echo "Garage Door 1 is not active"
fi

if [ $garageDoor2 = "active" ]; 
	then
		echo "Garage door 2 is active.  Updating config file for garage door 2"
		#sudo sed -i -e 's/emailAddressHere/'"'"'email:123456789@messaging.sprintpcs.com'"'"', '"'"'email:123456789@tmomail.net'"'"'/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/$garageDoor2CommentCode//g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor2Name/$garageDoor2Name/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor2Pin/$garageDoor2Pin/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor2AlertEmailAddress1/$emailAddresses/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor2AlarmOpenTimeOpen1/$garageDoor2AlarmOpenTimeOpen1/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor2AlertEmailAddress2/$emailAddresses/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor2AlarmOpenTimeOpen2/$garageDoor2AlarmOpenTimeOpen2/g" /usr/local/etc/pi_garage_alert_config.py
	else echo "Garage Door 2 is not active"
fi

if [ $garageDoor3 = "active" ]; 
	then
		echo "Garage door 3 is active.  Updating config file for garage door 3"
		#sudo sed -i -e 's/emailAddressHere/'"'"'email:123456789@messaging.sprintpcs.com'"'"', '"'"'email:123456789@tmomail.net'"'"'/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/$garageDoor3CommentCode//g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor3Name/$garageDoor3Name/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor3Pin/$garageDoor3Pin/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor3AlertEmailAddress1/$emailAddresses/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor3AlarmOpenTimeOpen1/$garageDoor3AlarmOpenTimeOpen1/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor3AlertEmailAddress2/$emailAddresses/g" /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e "s/garageDoor3AlarmOpenTimeOpen2/$garageDoor3AlarmOpenTimeOpen2/g" /usr/local/etc/pi_garage_alert_config.py
	else echo "Garage Door 3 is not active"
fi


# Reload postfix config
sudo /etc/init.d/postfix reload

#Send yourself a test email.  Replace username@example.com with your email address.
echo "test mail" | mail -s "Email test from installation of GarageBuddy" jt7561@gmail.com

# Setup the garage alert as a service and starts when rebooted
sudo update-rc.d pi_garage_alert defaults
sudo service pi_garage_alert restart

echo "Script complete"

