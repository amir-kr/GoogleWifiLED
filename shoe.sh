#!/bin/sh

RED="/sys/class/leds/LED0_Red"
GREEN="/sys/class/leds/LED0_Green"
BLUE="/sys/class/leds/LED0_Blue"

get_ping_value() {
  OUTPUT=$(sh /usr/local/LED/test.sh url_test_node %s %s)

  PING_RAW=$(echo "$OUTPUT" | cut -d ':' -f2)

  PING_DIGITS=$(echo "$PING_RAW" | tr -d '.' | cut -c1-4)
  echo "$PING_DIGITS"
}

set_color() {
  echo 0 > $RED/brightness
  echo 0 > $GREEN/brightness
  echo 0 > $BLUE/brightness
  case "$1" in
    green)
      echo 255 > $GREEN/brightness
      ;;
    yellow)
      echo 255 > $RED/brightness
      echo 255 > $GREEN/brightness
      ;;
    red)
      echo 255 > $RED/brightness
      ;;
    red_blink)
      echo timer > $RED/trigger
      echo 255 > $RED/brightness
      echo 500 > $RED/delay_on
      echo 500 > $RED/delay_off
      ;;
    off)
      ;;
  esac
}

reset_led_triggers() {
  echo none > $RED/trigger
  echo none > $GREEN/trigger
  echo none > $BLUE/trigger
}

while true; do
  reset_led_triggers

  PING=$(get_ping_value)

  if [ "$PING" = "0000" ] || [ "$PING" = "0" ]; then
    set_color red_blink
  elif [ "$PING" -ge 1200 ]; then
    set_color red
  elif [ "$PING" -ge 1100 ]; then
    set_color yellow
  else
    set_color green
  fi

  sleep 10 
done
