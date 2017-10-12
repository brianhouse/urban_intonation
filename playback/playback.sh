#!/bin/bash

PIDFILE=/var/run/playback.pid

case $1 in
   start)
      pd -nogui -verbose -audiodev 1 -r 48000 /home/pi/urban_intonation/playback/playback.pd 2>/dev/null &      
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