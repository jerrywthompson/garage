#!/bin/bash

### Installation steps:
### 1.  Clone Project from GitHub
##  	  git clone https://github.com/jerrywthompson/garagebuddy.git && cd garagebuddy && git checkout master && sudo apt-get -y install expect
### 2.  Update the config file located here:   
	  /home/pi/garagebuddy/garagebuddy.config
### 3.  Run the install script from /home/pi/garagebuddy Note: script is inside of /tools but run from garagebuddy directory
##  	  unbuffer bash tools/installGarageBuddy.sh 2>&1 | tee garageBuddyInstall.log
### NOTE:  Install logs are store here:   /home/pi/garagebuddy/garageBuddyInstall.log
### NOTE:  Runtime logs are stored here:  tail -f /var/log/pi_garage_alert.log


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


# Install and configure the alerting engine
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

#Send a test email.  Replace username@example.com with your email address.
echo "test mail" | mail -s "Email test from installation of GarageBuddy" *******@gmail.com

# Setup the garage alert as a service and starts when rebooted
sudo update-rc.d pi_garage_alert defaults
sudo service pi_garage_alert restart

echo "Script has completed setting the alert process."

# ********************* Setup and configure garage door remote control **********************
echo "***** Begin setup and configuration of the garage door remote control"

# Setup Apache/php
echo "***** Setting up and configuring Apache *****"
sudo apt-get install apache2 -y
sudo apt-get install php5 libapache2-mod-php5 -y

# Copy webpage files
echo "Configuring and moving webpage files"
# navigate to the webpage directory
echo "********** Naivgate to /home/pi/garaagebuddy/www **********"
cd /home/pi/garagebuddy/webpage
# removed directory if exists
echo "********** Delete /var/www/html/garagebuddy directory if present **********"
sudo rm -rf /var/www/html/garagebuddy 

# create new directory & copy all files and folders
echo "********** Create and copy all files and folders to /var/www/html/garagebuddy **********"
sudo mkdir /var/www/html/garagebuddy && sudo cp -vr *  /var/www/html/garagebuddy/


echo "Script complete"
