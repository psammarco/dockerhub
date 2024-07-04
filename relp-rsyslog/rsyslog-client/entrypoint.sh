#!/bin/bash

# Setting rsyslog servers variables
RSYSLOGSRV_CENTRAL="${RSYSLOGSRV_CENTRAL:-127.0.0.1}"
RSYSLOGSRV_SECONDARY="${RSYSLOGSRV_SECONDARY:-127.0.0.1}"

# rsyslog.conf variable PATH
rsyslogconf=/etc/rsyslog/rsyslog.conf

# Rsyslog forward config
{
    echo "*.* action("
    echo "    type=\"omrelp\""
    echo "    target=\"${RSYSLOGSRV_CENTRAL}\""
    echo "    port=\"22514\""
    echo "    tls=\"on\""
    echo "    tls.caCert=\"/rsyslog-certs/ca-cert.pem\""
    echo "    tls.tlscfgcmd=\"CipherString=ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384 MinProtocol=TLSv1.2 MaxProtocol=TLSv1.3\""
    echo ")"
} >> "$rsyslogconf"

{
    echo "*.* action("
    echo "    type=\"omrelp\""
    echo "    target=\"${RSYSLOGSRV_SECONDARY}\""
    echo "    port=\"22514\""
    echo "    tls=\"on\""
    echo "    tls.caCert=\"/rsyslog-certs/ca-cert.pem\""
    echo "    tls.tlscfgcmd=\"CipherString=ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384 MinProtocol=TLSv1.2 MaxProtocol=TLSv1.3\""
    echo "    action.execOnlyWhenPreviousIsSuspended=\"on\""
    echo ")"
} >> "$rsyslogconf"

{
    echo "*.* action("
    echo "    type=\"omfile\""
    echo "    file=\"/var/log/localbuffer\""
    echo "    action.execOnlyWhenPreviousIsSuspended=\"on\""
    echo ")"
} >> "$rsyslogconf"

# Slowing down the start to allow the container to load up properly in kubernetes
sleep 10

# Start rsyslog service
exec rsyslogd -n -f $rsyslogconf
