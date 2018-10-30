# garagebuddy

**** Updated instals instructions 10/30/18:

### Installation steps:
### Clone Project from GitHub
##  	git clone https://github.com/jerrywthompson/garagebuddy.git && cd garagebuddy
### Update the oonfig file located here:   /home/pi/garagebuddy/garagebuddy.config
### Install expect with the following commnad
## 		sudo apt-get -y install expect
### Run the install script from /home/pi/garagebuddy Note: script is inside of /tools but run from garagebuddy directory
##  	unbuffer bash tools/installGarageBuddy.sh 2>&1 | tee garagebuddy.log
