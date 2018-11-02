# garagebuddy

**** Updated install instructions 11/02/18:

### Installation steps:
``` bash
 1.  Clone Project from GitHub
   git clone https://github.com/jerrywthompson/garagebuddy.git && cd garagebuddy && git checkout master && sudo apt-get -y install expect
 2.  Update the config file located here:   
	  /home/pi/garagebuddy/garagebuddy.config
 3.  Run the install script from /home/pi/garagebuddy Note: script is inside of /tools but run from garagebuddy directory  	  unbuffer bash tools/installGarageBuddy.sh 2>&1 | tee garageBuddyInstall.log
```
### NOTE:  Install logs are store here:   /home/pi/garagebuddy/garageBuddyInstall.log
### NOTE:  Runtime logs are stored here:  tail -f /var/log/pi_garage_alert.log
