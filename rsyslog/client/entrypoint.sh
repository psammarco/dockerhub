#!/bin/bash

# Set RSYSLOGSRVIP variable here
RSYSLOGSRVIP="${RSYSLOGSRVIP:-127.0.0.1}"

# Configure rsyslog with the resolved environment variable
echo "*.* action(type=\"omfwd\" target=\"${RSYSLOGSRVIP}\" port=\"514\" protocol=\"udp\" action.resumeRetryCount=\"100\" queue.type=\"linkedList\" queue.size=\"10000\")" >> /etc/rsyslog.conf

# Start rsyslog service
exec rsyslogd -n
