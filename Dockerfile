ARG PKG="gcc make binutils libc6-compat g++ openssl-dev"

## Build Container
FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS build

ARG PKG
WORKDIR /src
COPY ./src /src

RUN apk add --no-cache --virtual .build-deps ${PKG} \
    && ./configure --prefix=/app --sysconfdir=/hopm \
    && make && make install \
    && apk del .build-deps


## Runtime Container
FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS app
COPY --from=build /app /app
WORKDIR /hopm
CMD ["/app/bin/hopm", "-d"]
