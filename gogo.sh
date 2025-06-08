#!/bin/sh

# Check if Passwall2 service is running using ubus
check_passwall2_status() {
    # Call ubus to get Passwall2 status
    status=$(ubus call luci.passwall2 get_status 2>/dev/null)

    if [ -n "$status" ]; then
        # Check if status contains "running" (depends on exact JSON output)
        echo "$status" | grep -q '"running":true'
        if [ $? -eq 0 ]; then
            echo "1"
            return 0
        else
            echo "0"
            return 1
        fi
    else
        # Fallback: Check if Xray/V2Ray process (used by Passwall2) is running
        if pgrep -f "xray" > /dev/null || pgrep -f "v2ray" > /dev/null; then
            echo "1"
            return 0
        else
            echo "0"
            return 1
        fi
    fi
}

# Execute the check
check_passwall2_status
