#!/bin/sh

# بررسی وضعیت اجرای Passwall2 یا ابزارهای وابسته
check_passwall2_status() {
    # دریافت وضعیت Passwall2 از طریق ubus
    status=$(ubus call luci.passwall2 get_status 2>/dev/null)

    if [ -n "$status" ]; then
        echo "$status" | grep -q '"running":true'
        if [ $? -eq 0 ]; then
            echo "1"
            return 0
        fi
    fi

    # بررسی اجرای پردازش xray، v2ray یا sing-box
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

# اجرای تابع
check_passwall2_status
