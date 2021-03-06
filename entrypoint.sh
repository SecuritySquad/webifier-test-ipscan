#!/usr/bin/env bash
cd /logs
touch temp.txt
bro -i eth0 local init.bro &
# Wait for bro to start
until pids=$(pidof bro)
do
    echo "waiting for process.."
    sleep 1
done
while :
do
  if [ -f loaded_scripts.log ]; then
    echo "bro finished loading!"
    break
  fi
  sleep 1
done
cd /
phantomjs --ignore-ssl-errors=true netsniff.js $URL >> /logs/temp.txt
cd logs
cat simple_conns.log
python /validate.py $ID
