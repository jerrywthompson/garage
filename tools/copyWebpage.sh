#!/bin/bash
echo "********** Starting copyWebpage.sh **********"

# navigate to the webpage directory
echo "********** Naivgate to /home/pi/garaagebuddy/www **********"
cd /home/pi/garagebuddy/webpage/www
#cd /home/pi/garagebuddy/

# removed directory if exists
echo "********** Delete /var/www/html/garagebuddy directory if present **********"
sudo rm -rf /var/www/html/garagebuddy 

# create new directory & copy all files and folders
echo "********** Create and copy all files and folders to /var/www/html/garagebuddy **********"
#sudo mkdir /var/www/html/garagebuddy && cp -vr *  /var/www/html/garagebudd
cp -vr *  /var/www/html/
