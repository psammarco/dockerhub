# RELP rsyslog server with TLS Authentication

## Quick intro
This is a two nodes relp-rsyslog server which uses relp-openssl to handle TLS authentication.

## Dropping privileges in rsyslo
In both the client and server configurations, rsyslogd initially starts as the ***root*** user but then drops privileges to run as a non-privileged user. This means that the only process running does so as the ***rsyslog*** user. However, the container itself still operates with root privileges, so if you execute a command within the container, it will be run as root. I am currently working on finding a solution to start rsyslogd *(with this very same configuration)* without requiring root privileges altogether. If and when that is achieved, the container itself will be able to run as a non-privileged user.

See *genkeys.tar.gz* for instructions on how to generate the keys.
