FROM ubuntu:bionic-20190612
LABEL maintainer="sameer@damagehead.com"

ENV SQUID_VERSION=3.5.27 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy\
    AUTH_USER=proxy \
    AUTH_PASSWORD=proxy

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid=${SQUID_VERSION}* apache2-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Create authentication directory
RUN mkdir -p /etc/squid/auth

COPY entrypoint.sh /sbin/entrypoint.sh
RUN sed -i 's/\r$//' /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
