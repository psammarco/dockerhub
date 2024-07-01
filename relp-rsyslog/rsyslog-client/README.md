### RELP rsyslog client with One Way TLS Authentication

## Break down
This is a demo setup designed to be used together with [rsyslog-server](https://github.com/psammarco/dockerhub/tree/main/relp-rsyslog/rsyslog-server) docker deployment.

The container uses *"RSYSLOGSRV_CENTRAL"* and *"RSYSLOGSRV_SECONDARY"* environment variables to set the rsyslog servers IP or domain name.

The entrypoint.sh instructs rsyslog to forward all logs to *RSYSLOGSRV_CENTRAL*, and only forward logs to *RSYSLOGSRV_SECONDARY* when the central rsyslog server is unavailable.
In the event both rsyslog servers are unavialable, rsyslog client will default to localhost.

It uses server-side authentication or one-way SSL/TLS authentication to verify the server's certificate using the CA certificate.


The following option configure the rsyslog client to use *ECDHE-ECDSA-AES256-GCM-SHA384* as main Cipher, while *ECDHE-RSA-AES256-GCM-SHA384* is used as fallback.

*MinProtocol* and *MaxProtocol* define the minumum and maximum version of TLS the client must use to authenticate with the server.
```
tls.tlscfgcmd="CipherString=ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384 MinProtocol=TLSv1.2 MaxProtocol=TLSv1.3")
```
Lastly, when either one or both rsyslog server is down, the client will log each contact request to */var/log/localbuffer*.

## Quick test
logger "whatever message"
