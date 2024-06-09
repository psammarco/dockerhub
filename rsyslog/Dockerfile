FROM debian:stable-slim 
ENV DEBIAN_FRONTEND=noninteractivie

# Installing PREREQs
RUN apt update && apt install --no-install-suggests -y \
rsyslog-kafka \
rsyslog-gnutls \
rsyslog-gssapi \
rsyslog-openssl \
rsyslog-mongodb \
rsyslog-hiredis \
rsyslog-kubernetes \
rsyslog-elasticsearch

# Cleaning up apt stuff..
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy rsyslog.conf to image
COPY rsyslog.conf /etc/rsyslog.conf

# Expose UDP port
EXPOSE 514/udp

CMD ["/usr/sbin/rsyslogd", "-n", "-f", "/etc/rsyslog.conf"]
