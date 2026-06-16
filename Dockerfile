ARG PKG="gcc make binutils libc6-compat g++ openssl-dev"

## Build Container
FROM alpine:3.24.1@sha256:bec4ccd3817e7c824eb0388971a0b83fab111d586285511ba0266b77e8dc65a9 AS build

ARG PKG
WORKDIR /src
COPY ./src /src

RUN apk add --no-cache --virtual .build-deps ${PKG} \
    && ./configure --prefix=/app --sysconfdir=/hopm \
    && make && make install \
    && apk del .build-deps


## Runtime Container
FROM alpine:3.24.1@sha256:bec4ccd3817e7c824eb0388971a0b83fab111d586285511ba0266b77e8dc65a9 AS app
COPY --from=build /app /app
WORKDIR /hopm
CMD ["/app/bin/hopm", "-d"]
