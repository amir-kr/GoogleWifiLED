#!/bin/sh

opkg update

opkg install coreutils-sleep

mkdir /usr/local/
mkdir /usr/local/LED/

cd /usr/local/LED/

rm *

wget https://raw.githubusercontent.com/amir-kr/GoogleWifiLED/refs/heads/main/choe.sh
sleep 1
chmod +x choe.sh
wget https://raw.githubusercontent.com/amir-kr/GoogleWifiLED/refs/heads/main/gogo.sh
sleep 1
chmod +x gogo.sh
wget https://raw.githubusercontent.com/amir-kr/GoogleWifiLED/refs/heads/main/led.sh
sleep 1
chmod +x led.sh
wget https://raw.githubusercontent.com/amir-kr/GoogleWifiLED/refs/heads/main/test.sh
sleep 1
chmod +x test.sh
wget https://raw.githubusercontent.com/amir-kr/GoogleWifiLED/refs/heads/main/shoe.sh
sleep 1
chmod +x shoe.sh
wget https://raw.githubusercontent.com/amir-kr/GoogleWifiLED/refs/heads/main/get.sh
chmod +x get.sh
sleep 1

TARGET_LINE="/usr/local/LED/led.sh &"
RC_LOCAL="/etc/rc.local"

grep -Fxq "$TARGET_LINE" "$RC_LOCAL"

if [ $? -ne 0 ]; then

    sed -i '/^exit 0$/i '"$TARGET_LINE" "$RC_LOCAL"
    echo "done"
else
    echo "duplicate"
fi


