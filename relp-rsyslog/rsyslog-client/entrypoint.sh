#!/bin/bash

# Setting rsyslog servers variables
RSYSLOGSRV_CENTRAL="${RSYSLOGSRV_CENTRAL:-127.0.0.1}"
RSYSLOGSRV_SECONDARY="${RSYSLOGSRV_SECONDARY:-127.0.0.1}"

# rsyslog.conf variable PATH
rsyslogconf=/etc/rsyslog/rsyslog.conf

# Rsyslog forward config
echo "*.* action(type=\"omrelp\" target=${RSYSLOGSRV_CENTRAL} port=\"22514\" \
    tls=\"on\" \
    tls.caCert=\"/rsyslog-certs/ca-cert.pem\" \
    tls.tlscfgcmd=\"CipherString=ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384 MinProtocol=TLSv1.2 MaxProtocol=TLSv1.3\")" >> $rsyslogconf

# Append configuration for secondary server to rsyslog.conf
echo "*.* action(type=\"omrelp\" target=${RSYSLOGSRV_SECONDARY} port=\"22514\" \
    tls=\"on\" \
    tls.caCert=\"/rsyslog-certs/ca-cert.pem\" \
    tls.tlscfgcmd=\"CipherString=ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384 MinProtocol=TLSv1.2 MaxProtocol=TLSv1.3\" \
    action.execOnlyWhenPreviousIsSuspended=\"on\")" >> $rsyslogconf

echo "*.* action(type=\"omfile\" file=\"/var/log/localbuffer\" action.execOnlyWhenPreviousIsSuspended=\"on\")" >> $rsyslogconf

# Slowing down the start to allow the container to load up properly in kubernetes
sleep 10

# Start rsyslog service
exec rsyslogd -n -f $rsyslogconf
