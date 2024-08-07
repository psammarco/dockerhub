#!/bin/bash

# Setting rsyslog servers variables
RSYSLOGSRV_CENTRAL="${RSYSLOGSRV_CENTRAL:-127.0.0.1}"
RSYSLOGSRV_SECONDARY="${RSYSLOGSRV_SECONDARY:-127.0.0.1}"


# Rsyslog forward config
# Append configuration for central server to rsyslog.conf
echo "*.* action(type=\"omrelp\" target=\"${RSYSLOGSRV_CENTRAL}\" port=\"22514\" \
    tls=\"on\" \
    tls.caCert=\"/rsyslog-certs/ca-cert.pem\" \
    tls.tlscfgcmd=\"CipherString=ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384 MinProtocol=TLSv1.2 MaxProtocol=TLSv1.3\")" >> /etc/rsyslog.conf

# Append configuration for secondary server to rsyslog.conf
echo "*.* action(type=\"omrelp\" target=\"${RSYSLOGSRV_SECONDARY}\" port=\"22514\" \
    tls=\"on\" \
    tls.caCert=\"/rsyslog-certs/ca-cert.pem\" \
    tls.tlscfgcmd=\"CipherString=ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384 MinProtocol=TLSv1.2 MaxProtocol=TLSv1.3\" \
    action.execOnlyWhenPreviousIsSuspended=\"on\")" >> /etc/rsyslog.conf

# Append error logging file 
echo "*.* action(type=\"omfile\" file=\"/var/log/localbuffer\" action.execOnlyWhenPreviousIsSuspended=\"on\")" >> /etc/rsyslog.conf

# Start rsyslog service
exec rsyslogd -n
