# Use the "RSYSLOGSRVIP" environment variable to set the rsyslog server IP
address or domain name.

# Build example
docker build -t rsyslog/client .
docker run -d --name rsyslog-client -e RSYSLOGSRVIP="172.17.0.2" rsyslog/client
docker exec -it rsyslog-client /bin/bash

# Test if rsyslog is working
logger "whatever message"
