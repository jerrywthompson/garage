# garagebuddy

**** Updated install instructions 11/02/18:

### Installation steps:

 ## 1.  Clone Project from GitHub
 ``` bash
   git clone https://github.com/jerrywthompson/garagebuddy.git && cd garagebuddy && git checkout master && sudo apt-get -y install expect
   ```
 ## 2.  Update the config file located here: 
 ``` bash
   /home/pi/garagebuddy/garagebuddy.config
```
 ## 3.  Run the install script from /home/pi/garagebuddy Note: script is inside of /tools but run from garagebuddy directory 
 ``` bash
  unbuffer bash tools/installGarageBuddy.sh 2>&1 | tee garageBuddyInstall.log
```
##### Logs:
``` bash
  Install logs are store here:   /home/pi/garagebuddy/garageBuddyInstall.log
  Runtime logs are stored here:  tail -f /var/log/pi_garage_alert.log
```
