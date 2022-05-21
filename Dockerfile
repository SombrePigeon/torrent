FROM alpine:latest as base
EXPOSE 9091
EXPOSE 51413/tcp
EXPOSE 51413/udp
ENV VIRTUAL_PORT 9091
RUN apk --no-cache add transmission-daemon \
    && mkdir -p /transmission/config \
    && chmod -R 1777 /transmission \
    && rm -rf /tmp/*
COPY ./settings.json /transmission/config/
STOPSIGNAL SIGTERM
ENTRYPOINT ["/usr/bin/transmission-daemon", "--foreground", "--config-dir", "/transmission/config"]

#DEV-----------
FROM base as dev
ENV VIRTUAL_HOST=torrent.fenrir.ovh.localhost
ENV LETSENCRYPT_HOST=torrent.fenrir.ovh.localhost

#PROD----------
FROM base as prod
ENV VIRTUAL_HOST=torrent.fenrir.ovh
ENV LETSENCRYPT_HOST=torrent.fenrir.ovh
