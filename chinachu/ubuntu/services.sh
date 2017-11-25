#!/bin/bash
if [ ! -s config.json ]; then
	cat config.sample.json > config.json
fi
if [ ! -s rules.json ]; then
	cat rules.sample.json > rules.json
fi

rm -f /var/run/chinachu-operator.pid > /dev/null 2>&1
rm -f /var/run/chinachu-wui.pid > /dev/null 2>&1

cd /usr/local/chinachu && sudo -H -u chinachu bash -c "PATH=/usr/local/chinachu/.nave/installed/6.9.2/bin:$PATH npm install diskusage@latest" # workaround
chown chinachu:chinachu /usr/local/chinachu/recorded
chown chinachu:chinachu /usr/local/chinachu/data
chown chinachu:chinachu /usr/local/chinachu/config.json
chown chinachu:chinachu /usr/local/chinachu/rules.json

/etc/init.d/chinachu-operator start
/etc/init.d/chinachu-wui start

tail -f /dev/null
