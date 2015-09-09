#!/bin/sh

# This will auto refresh and render when ready:
# IP 192.168.33.10 is hardcoded in Vagrantfile
cygstart 'http://192.168.33.10:9292/index.html#/dashboard/file/logstash.json'

vagrant halt 2>/dev/null
vagrant destroy --force  2>/dev/null
vagrant up
