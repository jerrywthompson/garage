#!/bin/bash

### run the script with this command to write output to file and screen
##   unbuffer bash installGarageBuddy.sh 2>&1 | tee garagebuddy.log

# Update Raspbian
echo "Updating the Raspbian image"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

# Install core apps
echo "Installng python and other core applications "
sudo apt-get -y install python-setuptools python-dev libffi-dev libssl-dev
sudo pip install -U Requests

# Install and configure the alert
echo "Installng the GarageBuddy alert"
#git clone https://github.com/rllynch/pi_garage_alert.git
# get config items
echo "Getting config items from file"
source garagebuddy.config

cd pi_garage_alert
sudo cp bin/pi_garage_alert.py /usr/local/sbin/
sudo cp etc/pi_garage_alert_config.py /usr/local/etc/
sudo cp init.d/pi_garage_alert /etc/init.d/
sudo chown pi /usr/local/etc/pi_garage_alert_config.py
sudo apt-get clean


sudo debconf-set-selections <<< $hostName
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get -y install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules
echo "Updating /ect/postfix/main.cf"
sudo sed -i -e 's/relayhost =/\
# Setup email smtp server\
relayhost = $relayhost\
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

# Update alert for each active garage door
echo "Modify the pi_garage_alert_config.py for each active garage door"
if [ $garageDoor1 = "active"]; 
	then
		echo "Garage door 1 is active.  Updating config file for garage door 1"
		#sudo sed -i -e 's/emailAddressHere/'"'"'email:123456789@messaging.sprintpcs.com'"'"', '"'"'email:123456789@tmomail.net'"'"'/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/$garageDoor1CommentCode//g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor1Name/$garageDoor1Name/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor1Pin/$garageDoor1Pin/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor1AlertEmailAddress1/$garageDoor1AlertEmailAddress1/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor1AlarmOpenTimeOpen1/$garageDoor1AlarmOpenTimeOpen1/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor1AlertEmailAddress2/$garageDoor1AlertEmailAddress2/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor1AlarmOpenTimeOpen2/$garageDoor1AlarmOpenTimeOpen2/g' /usr/local/etc/pi_garage_alert_config.py
	else "Garage Door 1 is not active"
fi

if [ $garageDoor2 = "active" ]; 
	then
		echo "Garage door 2 is active.  Updating config file for garage door 2"
		#sudo sed -i -e 's/emailAddressHere/'"'"'email:123456789@messaging.sprintpcs.com'"'"', '"'"'email:123456789@tmomail.net'"'"'/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/$garageDoor2CommentCode//g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor2Name/$garageDoor2Name/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor2Pin/$garageDoor2Pin/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor2AlertEmailAddress1/$garageDoor2AlertEmailAddress1/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor2AlarmOpenTimeOpen1/$garageDoor2AlarmOpenTimeOpen1/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor2AlertEmailAddress2/$garageDoor2AlertEmailAddress2/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor2AlarmOpenTimeOpen2/$garageDoor2AlarmOpenTimeOpen2/g' /usr/local/etc/pi_garage_alert_config.py
	else "Garage Door 2 is not active"
fi

if [ $garageDoor3 = "active"]; 
	then
		echo "Garage door 3 is active.  Updating config file for garage door 3"
		#sudo sed -i -e 's/emailAddressHere/'"'"'email:123456789@messaging.sprintpcs.com'"'"', '"'"'email:123456789@tmomail.net'"'"'/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/$garageDoor3CommentCode//g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor3Name/$garageDoor3Name/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor3Pin/$garageDoor3Pin/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor3AlertEmailAddress1/$garageDoor3AlertEmailAddress1/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor3AlarmOpenTimeOpen1/$garageDoor3AlarmOpenTimeOpen1/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor3AlertEmailAddress2/$garageDoor3AlertEmailAddress2/g' /usr/local/etc/pi_garage_alert_config.py
		sudo sed -i -e 's/garageDoor3AlarmOpenTimeOpen2/$garageDoor3AlarmOpenTimeOpen2/g' /usr/local/etc/pi_garage_alert_config.py
	else "Garage Door 3 is not active"
fi

# loop tough emails config items
#for i in ${email//,/ }
#do
    # call your procedure/other scripts here below
  #  echo "$i"
#done

# Update GPIO pin numbers
#echo "Update GPIO pin numbers"
#sudo sed -i-e 's/15/24/g' /usr/local/etc/pi_garage_alert_config.py

# Reload postfix config
sudo /etc/init.d/postfix reload

#Send yourself a test email.  Replace username@example.com with your email address.
echo "test mail" | mail -s "test subject" username@example.com

# Setup the garage alert as a service and starts when rebooted
sudo update-rc.d pi_garage_alert defaults
sudo service pi_garage_alert restart

