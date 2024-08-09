### RELP rsyslog client with TLS Authentication

## Break down
This is a demo setup designed to be used together with [rsyslog-server](https://github.com/psammarco/dockerhub/tree/main/relp-rsyslog/rsyslog-server) docker deployment.

The container uses *"RSYSLOGSRV_CENTRAL"* and *"RSYSLOGSRV_SECONDARY"* environment variables to set the rsyslog servers IP or domain name.

The entrypoint.sh instructs rsyslog to forward all logs to *RSYSLOGSRV_CENTRAL*, and only forward logs to *RSYSLOGSRV_SECONDARY* when the central rsyslog server is unavailable.
In the event both rsyslog servers are unavialable, rsyslog client will default to localhost.

The following option configure the rsyslog client to use *ECDHE-ECDSA-AES256-GCM-SHA384* as main Cipher, while *ECDHE-RSA-AES256-GCM-SHA384* is used as fallback.

*MinProtocol* and *MaxProtocol* define the minumum and maximum version of TLS the client must use in order to be able to authenticate with the server.
```
tls.tlscfgcmd="CipherString=ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384 MinProtocol=TLSv1.2 MaxProtocol=TLSv1.3")
```
Lastly, when either one or both rsyslog server is down, the client will log unsuccessful requests to */var/log/localbuffer*.

## Dropping privileges in rsyslo
In both the client and server configurations, rsyslogd initially starts as the ***root*** user but then drops privileges to run as a non-privileged user. This means that the only process running does so as the ***rsyslog*** user. However, the container itself still operates with root privileges, so if you execute a command within the container, it will be run as root. I am currently working on finding a solution to start rsyslogd *(with this very same configuration)* without requiring root privileges altogether. If and when that is achieved, the container itself will be able to run as a non-privileged user.

## Quick test
logger "whatever message"
