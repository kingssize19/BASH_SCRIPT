#!/usr/bin/bash

BASE_IP="10.62.2.1"

echo "IP taraması başlatılıyor..."

for i in {1..200}
do
	IP="$BASE_IP.$i"
	# Ping ile kontrol (1 paket, sessiz)
	if ping -c 1 -W $IP > /dev/null 2>&1
	then
		echo "$IP : Dolu"
	else
		echo "$IP : Boş"
	fi
done
