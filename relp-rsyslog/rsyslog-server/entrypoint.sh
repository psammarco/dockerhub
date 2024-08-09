#!/bin/sh 

# Sorting permissions to log dir
chown -R rsyslog:rsyslogd /var/log

# Starting rsyslogd
exec /usr/sbin/rsyslogd -n -f /etc/rsyslog.conf

