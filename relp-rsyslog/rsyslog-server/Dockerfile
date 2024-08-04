FROM debian:stable-slim 
ENV DEBIAN_FRONTEND=noninteractivie

# Installing PREREQs
RUN apt update && apt upgrade -y
RUN apt install --no-install-suggests -y \
rsync \
rsyslog-relp

# Cleaning up apt stuff..
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Create unprivileged user
RUN groupadd rsyslogd && \
    useradd -r -m -s /bin/bash -g rsyslogd rsyslog && \
    chown -R rsyslog:rsyslogd /home/rsyslog 

# Sorting permissions to log dir
RUN chown -R rsyslog:rsyslogd /var/log

# Expose RELP port
EXPOSE 22514/tcp

CMD ["/usr/sbin/rsyslogd", "-n", "-f", "/etc/rsyslog.conf"]
