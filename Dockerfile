ARG PKG="git gcc make binutils libc6-compat g++ openssl-dev"

FROM alpine:3.20.3 AS build
ARG PKG
#COPY ./hopm /usr/src/hopm
WORKDIR /src
RUN apk add --no-cache --virtual .build-deps ${PKG} \
    && git clone --depth 1 https://github.com/ircd-hybrid/hopm.git /src \
    && ./configure --prefix=/app --sysconfdir=/hopm \
    && make && make install \
    && apk del .build-deps

FROM alpine:3.20.3 AS app
COPY --from=build /app /app
WORKDIR /hopm
CMD ["/app/bin/hopm", "-d"]
