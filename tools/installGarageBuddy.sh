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
echo "emailfomr config: " $email  
cd pi_garage_alert
sudo cp bin/pi_garage_alert.py /usr/local/sbin/
sudo cp etc/pi_garage_alert_config.py /usr/local/etc/
sudo cp init.d/pi_garage_alert /etc/init.d/
sudo chown pi /usr/local/etc/pi_garage_alert_config.py
sudo apt-get clean

# Setup and config email
echo "Setting up email"
sudo debconf-set-selections <<< "postfix postfix/mailname string your.hostname.com"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get -y install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules
echo "Updating /ect/postfix/main.cf"
sudo sed -i -e 's/relayhost =/\
# Setup email smtp server\
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
sudo echo "[smtp.gmail.com]:587 username@gmail.com:gmail_password" >> /etc/postfix/sasl_passwd
sudo chmod 400 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd

# Reload postfix config
sudo /etc/init.d/postfix reload

#Send yourself a test email.  Replace username@example.com with your email address.
echo "test mail" | mail -s "test subject" username@example.com

# Setup the garage alert as a service and starts when rebooted
sudo update-rc.d pi_garage_alert defaults
sudo service pi_garage_alert restart


# Update pi_garage_alert_config file
echo "********** Starting to update pi_garage_alert_config **********"

# Add phone phone numbers for text alerting
echo "Adding mobile phone numbers for text alerts"
echo "Getting config items from file"
source garagebuddy.config
echo "emailfomr config: " $email 
# loop tough emails config items
for i in ${email//,/ }
do
    # call your procedure/other scripts here below
    echo "$i"
done


sudo sed -i -e 's/emailAddressHere/'"'"'email:123456789@messaging.sprintpcs.com'"'"', '"'"'email:123456789@tmomail.net'"'"'/g' /usr/local/etc/pi_garage_alert_config.py

# Update GPIO pin numbers
echo "Update GPIO pin numbers"
sudo sed -i-e 's/15/24/g' /usr/local/etc/pi_garage_alert_config.py

