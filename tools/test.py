#!/usr/bin/python2.7

##############################################################################
# Global settings
##############################################################################

# Describes all the garage doors being monitored
GARAGE_DOORS = [
    {
        'pin': 16,
        'name': "Garage Door 1",
        'alerts': [
            {
                'state': 'open',
                'time': 120,
                'recipients': [ 'email:8168853837@messaging.sprintpcs.com', 'email:8165227655@tmomail.net' ]
            },
            {
                'state': 'open',
                'time': 600,
                'recipients': [ 'email:8168853837@messaging.sprintpcs.com', 'email:8165227655@tmomail.net' ]
            }
        ]
    },

    {
        'pin': 24,
        'name': "Garage Door 1",
        'alerts': [
            {
                'state': 'open',
                'time': 120,
                'recipients': [ 'email:8168853837@messaging.sprintpcs.com', 'email:8165227655@tmomail.net']
            },
            {
                'state': 'open',
                'time': 600,
                'recipients': [ 'email:8168853837@messaging.sprintpcs.com', 'email:8165227655@tmomail.net' ]
            }
        ]
    }
]

# All messages will be logged to stdout and this file
LOG_FILENAME = "/var/log/pi_garage_alert.log"

##############################################################################
# Email settings
##############################################################################

SMTP_SERVER = 'localhost'
SMTP_PORT = 25
SMTP_USER = ''
SMTP_PASS = ''
EMAIL_FROM = 'Garage Door <user@example.com>'
EMAIL_PRIORITY = '1'
# 1 High, 3 Normal, 5 Low
