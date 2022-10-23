ARG PKG="git gcc make binutils libc6-compat g++ openssl-dev"
ARG UID=1001
ARG GID=1001

FROM alpine:3.16.2
ARG PKG
ARG UID
ARG GID

WORKDIR /usr/src/hopm
RUN set -x \
    && apk add --no-cache --virtual build ${PKG} \
    && git clone --depth 1 https://github.com/ircd-hybrid/hopm.git /usr/src/hopm \
    && ./configure --prefix=/app --sysconfdir=/hopm \
    && make && make install \
    && rm -rf /usr/src/hopm \
    && apk del build \
    && addgroup -g ${GID} -S hopm && adduser --uid ${UID} --home /hopm -S hopm -G hopm \
    && chown -R hopm:hopm /app

USER hopm
WORKDIR /hopm
CMD ["/app/bin/hopm", "-d"]
