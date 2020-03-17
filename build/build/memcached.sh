#!/bin/bash
# Created on 2020-03-17T16:06:46+1100, using template:memcached.sh.tmpl and json:gearbox.json

test -f /etc/gearbox/bin/colors.sh && . /etc/gearbox/bin/colors.sh

c_ok "Started."

c_ok "Installing packages."
APKBIN="$(which apk)"
if [ "${APKBIN}" != "" ]
then
	if [ -f /etc/gearbox/build/memcached.apks ]
	then
		APKS="$(cat /etc/gearbox/build/memcached.apks)"
		${APKBIN} update && ${APKBIN} add --no-cache ${APKS}; checkExit
	fi
fi

APTBIN="$(which apt-get)"
if [ "${APTBIN}" != "" ]
then
	if [ -f /etc/gearbox/build/memcached.apt ]
	then
		DEBS="$(cat /etc/gearbox/build/memcached.apt)"
		${APTBIN} update && ${APTBIN} install ${DEBS}; checkExit
	fi
fi


if [ -f /etc/gearbox/build/memcached.env ]
then
	. /etc/gearbox/build/memcached.env
fi

if [ ! -d /usr/local/bin ]
then
	mkdir -p /usr/local/bin; checkExit
fi

c_ok "Finished."
