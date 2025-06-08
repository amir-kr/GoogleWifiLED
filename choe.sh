#!/bin/sh

RED="/sys/class/leds/LED0_Red/brightness"
GREEN="/sys/class/leds/LED0_Green/brightness"
BLUE="/sys/class/leds/LED0_Blue/brightness"
SLEEP="sleep"

dim_mix() {
  R=$1
  G=$2
  B=$3
  for i in $(seq 0 5 255); do
    echo $((R * i / 255)) > $RED
    echo $((G * i / 255)) > $GREEN
    echo $((B * i / 255)) > $BLUE
    $SLEEP 0.005
  done
  for i in $(seq 255 -5 0); do
    echo $((R * i / 255)) > $RED
    echo $((G * i / 255)) > $GREEN
    echo $((B * i / 255)) > $BLUE
    $SLEEP 0.005
  done
  echo 0 > $RED
  echo 0 > $GREEN
  echo 0 > $BLUE
}

while true; do
  dim_mix 255 0 0     # قرمز
  dim_mix 0 255 0     # سبز
  dim_mix 0 0 255     # آبی
  dim_mix 255 0 255   # بنفش = قرمز + آبی
  dim_mix 255 255 0   # زرد = قرمز + سبز
  dim_mix 255 255 255 # سفید = همه رنگ‌ها
done
