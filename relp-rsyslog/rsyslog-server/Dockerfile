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
RUN groupadd -g 1000 rsyslogd && \
    useradd -r -m -u 1000 -s /bin/bash -g rsyslogd rsyslog && \
    chown -R rsyslog:rsyslogd /home/rsyslog

# Expose RELP port
EXPOSE 22514/tcp

# Entrypoint copy and permissions
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

