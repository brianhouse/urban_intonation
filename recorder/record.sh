#!/bin/bash

PIDFILE=/var/run/recorder.pid

case $1 in
   start)
       arecord -D plughw:1,0 -c 1 -f S16_LE -r 192000 -t wav --max-file-time 3600 /home/pi/urban_intonation/recorder/output/`date +%s`.wav 2>/dev/null &
       echo $! > ${PIDFILE} 
   ;;
   stop)
      kill `cat ${PIDFILE}`
      rm ${PIDFILE}
   ;;
   *)
      echo "usage: {start|stop}" ;;
esac
exit 0






# http://linuxcommand.org/man_pages/arecord1.html
#
# -D device
# -d duration in seconds
# -c channels
# -f format. S16_LE is 16-bit. S24_LE is 24-bit.
# -r sampling rate. 44100, 48000, 96000, 192000.
# -t file type. wav.
# --max-file-time 3600  split the file every hour
#
#
# arecord -l to list devices
# get card number, then device number
# plughw:card,device
#
# alsamixer to control levels
#
#
# beware: http://blog.nagimov.com/alsa-utils-arecord-bug-lots-of-wav-files-ignoring-duration-parameter/
# instead of this, upgrade to alsa 1.1.3 from source: https://stackoverflow.com/questions/24629915/multiple-files-created-by-arecord
#
#
#
# Bits per sample x samples per second = bits per second / 8 = Bytes per second x 60 seconds = Bytes per minute x 60 minutes = Bytes per hour of mono
# 24 * 192 = 4608 /8 = 576 * 60 = 34560 * 60 = 2073600 bytes per hour = 2gigs per hour * 24 = 48gigs for 24 hour recording