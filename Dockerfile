ARG PKG="git gcc make binutils libc6-compat g++ openssl-dev"

FROM alpine:3.15.1
ARG PKG
#COPY ./hopm /usr/src/hopm
WORKDIR /usr/src/hopm
RUN apk add --no-cache --virtual build ${PKG} \
    && git clone --depth 1 https://github.com/ircd-hybrid/hopm.git /usr/src/hopm \
    && ./configure --prefix=/usr/local --sysconfdir=/hopm \
    && make && make install \
    && rm -rf /usr/src/hopm \
    && apk del build
WORKDIR /hopm
CMD ["/usr/local/bin/hopm", "-d"]
