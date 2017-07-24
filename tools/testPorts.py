#!/usr/bin/python
import RPi.GPIO as GPIO 
import time

GPIO.setmode(GPIO.BCM)

# init list with pin numbers
pinNum = 4

# set mode and state to 'high'
GPIO.setup(pinNum, GPIO.OUT) 
GPIO.output(pinNum, GPIO.LOW) 

SleepTimeSeconds = 1.0


# Turn in pin for xx seconds
GPIO.output(pinNum, GPIO.HIGH) 

print "status: GPIO.HIGH" 

time.sleep(SleepTimeSeconds)

GPIO.output(pinNum, GPIO.LOW)

print "status: GPIO.LOW" 

time.sleep(SleepTimeSeconds)

# Reset GPIO settings
GPIO.cleanup()

print "Quit"

quit()



# find more information on this script at http://youtu.be/WpM1aq4B8-A

