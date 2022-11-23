ARG PKG="git gcc make binutils libc6-compat g++ openssl-dev"

FROM alpine:3.17.0 AS build
ARG PKG
#COPY ./hopm /usr/src/hopm
WORKDIR /src
RUN apk add --no-cache --virtual build ${PKG} \
    && git clone --depth 1 https://github.com/ircd-hybrid/hopm.git /src \
    && ./configure --prefix=/app --sysconfdir=/hopm \
    && make && make install

FROM alpine:3.17.0 AS app
COPY --from=build /app /app
WORKDIR /hopm
CMD ["/app/bin/hopm", "-d"]
