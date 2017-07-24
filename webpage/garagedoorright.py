#!/usr/bin/python

# Import required Python libraries
import RPi.GPIO as GPIO
import time

# Use BCM GPIO references instead of physical pin numbers
GPIO.setmode(GPIO.BCM)

# GPIO# assigned to garage door
pinNum = [18]

# set mode and state to 'high' to activate garage door
GPIO.setup(pinNum, GPIO.OUT)
GPIO.output(pinNum, GPIO.HIGH)

time.sleep(0.5)

# Set pin back to low
GPIO.output(pinNum, GPIO.LOW)

# Reset GPIO settings
GPIO.cleanup()
