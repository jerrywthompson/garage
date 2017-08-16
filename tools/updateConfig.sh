# Update Raspbian
echo "Updating the Raspbian image"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade





# Update pi_garage_alert_config file
echo "********** Starting to update pi_garage_alert_config **********"

# Add phone phone numbers for text alerting
echo "Adding mobile phone numbers for text alerts"
sed -i -e 's/email:someone@example.com/'"'"'email:8168853837@messaging.sprintpcs.com'"'"', '"'"'email:8165227655@tmomail.net'"'"'/g' test.py

# Update GPIO pin numbers
echo "Update GPIO pin numbers"
sed -i-e 's/15/24/g' test.py

