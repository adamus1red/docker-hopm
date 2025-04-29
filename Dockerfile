ARG PKG="gcc make binutils libc6-compat g++ openssl-dev"

## Build Container
FROM alpine:3.21.3@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c AS build

ARG PKG
WORKDIR /src
COPY ./src /src

RUN apk add --no-cache --virtual .build-deps ${PKG} \
    && ./configure --prefix=/app --sysconfdir=/hopm \
    && make && make install \
    && apk del .build-deps


## Runtime Container
FROM alpine:3.21.3@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c AS app
COPY --from=build /app /app
WORKDIR /hopm
CMD ["/app/bin/hopm", "-d"]
