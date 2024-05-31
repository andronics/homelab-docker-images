FROM andronics/base

LABEL org.opencontainers.image.source="https://github.com/andronics/homelab-docker-images.git" \
    org.opencontainers.image.url="https://github.com/andronics/homelab-docker-images/tree/openvpn-proxy"

RUN \
    echo "# Installing Packages #" && \
        apk --no-cache --update add \
            bind-tools \
            dante-server \
            openvpn \
            tinyproxy \
            unbound \
            unzip && \
    echo "# Removing Cache #" && \
        rm -rf /var/cache/apk/*

RUN \
    echo "# Updating Unbound Internic Root Hints" && \
        curl -s https://www.internic.net/domain/named.cache -o /etc/unbound/root.hints

COPY ./rootfs /

RUN \
    echo "# Chaning Permissions #" && \
        find /etc/services.d -type f -exec chmod u+x {} \;

HEALTHCHECK --interval=5m --timeout=20s --start-period=1m \
    CMD ['/etc/services.d/healthcheck']

