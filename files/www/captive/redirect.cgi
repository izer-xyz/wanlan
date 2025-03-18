#!/bin/sh

echo HTTP/$HTTPS - $REMOTE_ADDR - $HTTP_HOST$REQUEST_URI > /dev/kmsg

echo "Status: 302 Temporary Redirect"
echo "Location: http://192.168.1.1"
echo ""

exit 0
