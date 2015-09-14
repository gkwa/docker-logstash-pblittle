mkdir -p /opt/logstash/conf.d
cp logstash-test.conf /opt/logstash/conf.d
chmod -R 777 /opt/logstash/conf.d/*

exit

wget -nc ftp://ita.ee.lbl.gov/traces/NASA_access_log_Jul95.gz
[ ! -f access_log_Jul95 ] && 7za x NASA_access_log_Jul95.gz
sleep 60 # wait for server to come online
cat access_log_Jul95 | nc -v -w 1 127.0.0.1 1514
