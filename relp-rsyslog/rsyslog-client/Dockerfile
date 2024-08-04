FROM debian:stable-slim 
ENV DEBIAN_FRONTEND=noninteractivie

# Installing PREREQs
RUN apt update && apt install --no-install-suggests --no-install-recommends -y \
rsyslog-relp

# Cleaning up apt stuff..
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy rsyslog.conf to image
COPY rsyslog.conf /etc/rsyslog.conf

# Create unprivileged user
RUN groupadd rsyslogd && \
    useradd -r -m -s /bin/bash -g rsyslogd rsyslog && \
    chown -R rsyslog:rsyslogd /home/rsyslog 

# Sorting permissions to log dir
RUN chown -R rsyslog:rsyslogd /var/log

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint to be executed as root
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
