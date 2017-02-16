#!/usr/bin/env bash
cd /logs
touch temp.txt
bro -i eth0 local init.bro &
cd /
phantomjs netsniff.js $URL >> /logs/temp.txt
cd logs
cat simple_conns.log
python /validate.py $ID
