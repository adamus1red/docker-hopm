ARG PKG="gcc make binutils libc6-compat g++ openssl-dev"

## Build Container
FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS build

ARG PKG
WORKDIR /src
COPY ./src /src

RUN apk add --no-cache --virtual .build-deps ${PKG} \
    && ./configure --prefix=/app --sysconfdir=/hopm \
    && make && make install \
    && apk del .build-deps


## Runtime Container
FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS app
COPY --from=build /app /app
WORKDIR /hopm
CMD ["/app/bin/hopm", "-d"]
