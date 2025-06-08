#!/bin/sh

LED_SCRIPT="/usr/local/LED/shoe.sh"
CHOS_SCRIPT="/usr/local/LED/choe.sh"
CURRENT_STATE=""
LED_PID=""

stop_led() {
  echo none > /sys/class/leds/LED0_Red/trigger
  echo 0 > /sys/class/leds/LED0_Red/brightness
  echo none > /sys/class/leds/LED0_Green/trigger
  echo 0 > /sys/class/leds/LED0_Green/brightness
  echo none > /sys/class/leds/LED0_Blue/trigger
  echo 0 > /sys/class/leds/LED0_Blue/brightness
}

kill_running() {
  if [ -n "$LED_PID" ] && kill -0 "$LED_PID" 2>/dev/null; then
    kill "$LED_PID"
    wait "$LED_PID" 2>/dev/null
  fi
  stop_led
}

while true; do
  STATUS=$(sh /usr/local/LED/gogo.sh)

  if [ "$STATUS" != "$CURRENT_STATE" ]; then
    kill_running

    if [ "$STATUS" = "1" ]; then
      sh $LED_SCRIPT & LED_PID=$!
    else
      sh $CHOS_SCRIPT & LED_PID=$!
    fi

    CURRENT_STATE="$STATUS"
  fi

  sleep 10
done

