#!/bin/sh

check_passwall2_status() {
    status=$(ubus call luci.passwall2 get_status 2>/dev/null)

    if [ -n "$status" ]; then
        echo "$status" | grep -q '"running":true'
        if [ $? -eq 0 ]; then
            echo "1"
            return 0
        fi
    fi

    if pgrep -f "xray" > /dev/null || \
       pgrep -f "v2ray" > /dev/null || \
       pgrep -f "sing-box" > /dev/null; then
        echo "1"
        return 0
    else
        echo "0"
        return 1
    fi
}

check_passwall2_status
