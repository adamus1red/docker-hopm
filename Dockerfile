## Build Container
FROM cgr.dev/chainguard/gcc-glibc:latest AS build
ARG PKG
WORKDIR /src
COPY ./src /src
RUN  ./configure --prefix=/app --sysconfdir=/hopm \
    && make && make install

## Runtime Container
FROM cgr.dev/chainguard/glibc-dynamic:latest AS app
COPY --from=build /app /app
WORKDIR /hopm
CMD ["/app/bin/hopm", "-d"]
