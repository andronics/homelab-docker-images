FROM alpine:3.18.2

LABEL org.opencontainers.image.authors="andronics@gmail.com" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/andronics/homelab-docker-images.git" \
    org.opencontainers.image.url="https://github.com/andronics/homelab-docker-images" \
    org.opencontainers.image.vendor="andronics"

RUN \
    echo "# Add Community Edge Repository #" && \
        echo "@community https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "# Installing Packages #" && \
        apk --no-cache --update add \
            bash \
            ca-certificates \
            curl \
            jq \
            nano \
            runit \
            tzdata && \
    echo "# Removing Cache #" && \
        rm -rf /var/cache/apk/* && \
    echo "# Creating Folders #" && \
        mkdir \
            -p /etc/services.d && \
    echo "# Chaning Permissions #" && \
        find /etc/services -type f -exec chmod u+x {} \;

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /etc/services.d

CMD ["runsvdir", "/etc/services.d"]