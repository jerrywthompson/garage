#!/usr/bin/python2.7

##############################################################################
# Global settings
##############################################################################

# Describes all the garage doors being monitored
GARAGE_DOORS = [
#1#    {
#1#        'pin': garageDoor1Pin,
#1#        'name': "garageDoor1Name",
#1#        'alerts': [
#1#            {
#1#                'state': 'open',
#1#                'time': garageDoor1AlarmOpenTimeOpen1,
#1#                'recipients': [ garageDoor1AlertEmailAddress1 ]
#1#            },
#1#            {
#1#                'state': 'open',
#1#                'time': garageDoor1AlarmOpenTimeOpen2,
#1#                'recipients': [ garageDoor1AlertEmailAddress2 ]
#1#         }
#1#        ]
#1#    }
#2#    , {
#2#        'pin': garageDoor2Pin,
#2#        'name': "garageDoor2Name",
#2#        'alerts': [
#2#            {
#2#                'state': 'open',
#2#                'time': garageDoor2AlarmOpenTimeOpen1,
#2#                'recipients': [ garageDoor2AlertEmailAddress1 ]
#2#            },
#2#            {
#2#                'state': 'open',
#2#                'time': garageDoor2AlarmOpenTimeOpen2,
#2#                'recipients': [ garageDoor2AlertEmailAddress2 ]
#2#            }
#2#        ]
#2#    }
#3#    , {
#3#        'pin': garageDoor3Pin,
#3#        'name': "garageDoor3Name",
#3#        'alerts': [
#3#            {
#3#                'state': 'open',
#3#                'time': garageDoor3AlarmOpenTimeOpen1,
#3#                'recipients': [ garageDoor3AlertEmailAddress1 ]
#3#            },
#3#            {
#3#                'state': 'open',
#3#                'time': garageDoor3AlarmOpenTimeOpen2,
#3#                'recipients': [ garageDoor3AlertEmailAddress2 ]
#3#            }
#3#        ]
#3#    }
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

##############################################################################
# Cisco Spark settings
##############################################################################

# Obtain your access token from https://developer.ciscospark.com, click
# on your avatar at the top right corner.

SPARK_ACCESSTOKEN = "" #put your access token here between the quotes.

##############################################################################
# Twitter settings
##############################################################################

# Follow the instructions on http://talkfast.org/2010/05/31/twitter-from-the-command-line-in-python-using-oauth/
# to obtain the necessary keys

TWITTER_CONSUMER_KEY = ''
TWITTER_CONSUMER_SECRET = ''
TWITTER_ACCESS_KEY = ''
TWITTER_ACCESS_SECRET = ''

##############################################################################
# Twilio settings
##############################################################################

# Sign up for a Twilio account at https://www.twilio.com/
# then these will be listed at the top of your Twilio dashboard

TWILIO_ACCOUNT = ''
TWILIO_TOKEN = ''

# SMS will be sent from this phone number
TWILIO_PHONE_NUMBER = '+11234567890'

##############################################################################
# Jabber settings
##############################################################################

# Jabber ID and password that status updates will be sent from
# Leave this blank to disable Jabber support

JABBER_ID = ''
JABBER_PASSWORD = ''

# Uncomment to override the default server specified in DNS SRV records

#JABBER_SERVER = 'talk.google.com'
#JABBER_PORT = 5222

# List of Jabber IDs allowed to perform queries

JABBER_AUTHORIZED_IDS = []

##############################################################################
# Google Cloud Messaging settings
##############################################################################

GCM_KEY = ''
GCM_TOPIC = ''

##############################################################################
# IFTTT Maker Channel settings
# Create an applet using the "Maker" channel, pick a event name,
# and use the event name as a recipient of one of the alerts,
# e.g. 'recipients': [ 'ifft:garage_event' ]
#
# Get the key by going to https://ifttt.com/services/maker/settings.
# The key is the part of the URL after https://maker.ifttt.com/use/.
# Do not include https://maker.ifttt.com/use/ in IFTTT_KEY.
##############################################################################

IFTTT_KEY = ''

##############################################################################
# Slack settings
# Send messages to a team slack channel
# e.g. 'recipients': [ 'slack:<your channel ID>']
#   where <your channel ID> is the name or ID of the slack channel you want to
#   send to
#
# To use this functionality you will need to create a bot user to do the posting
# For information on how to create the bot user and get your API token go to:
#   https://api.slack.com/bot-users
#
# Note that the bot user must be added to the channel you want to post
# notifications in
##############################################################################
SLACK_BOT_TOKEN = ''
