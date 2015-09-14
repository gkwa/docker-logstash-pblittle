mkdir -p /opt/logstash/conf.d
cp logstash.conf /opt/logstash/conf.d
chmod -R 777 /opt/logstash/conf.d/*

docker stop logstash
docker rm logstash

docker run \
-d \
--name logstash \
-v /opt/logstash/conf.d:/opt/logstash/conf.d \
-e 9200=9200 \
-p 9200:9200 \
-e 9292=9292 \
-p 9292:9292 \
-p 1514:514 \
taylor/logstash:latest

docker exec logstash bash -c 'cat /opt/logstash/conf.d/logstash.conf'

wget -nc ftp://ita.ee.lbl.gov/traces/NASA_access_log_Jul95.gz
[ ! -f access_log_Jul95 ] && 7za x NASA_access_log_Jul95.gz
sleep 10 # wait for server to come online
cat access_log_Jul95 | nc -v -w 1 127.0.0.1 1514

docker exec logstash bash -c 'sleep 20 && tail -F /var/log/logstash/ls.txt'
