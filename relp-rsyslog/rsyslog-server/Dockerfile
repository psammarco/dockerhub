FROM debian:stable-slim 
ENV DEBIAN_FRONTEND=noninteractivie

# Installing PREREQs
RUN apt update && apt upgrade -y
RUN apt install --no-install-suggests -y \
rsyslog-relp \
rsyslog-kafka \
rsyslog-gssapi \
rsyslog-openssl \
rsyslog-mongodb \
rsyslog-hiredis \
rsyslog-kubernetes \
rsyslog-elasticsearch

# Cleaning up apt stuff..
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Expose RELP port
EXPOSE 22514/tcp

CMD ["/usr/sbin/rsyslogd", "-n", "-f", "/etc/rsyslog/rsyslog.conf"]
