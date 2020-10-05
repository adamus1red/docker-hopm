# HOPM Docker
[![Docker Pulls](https://img.shields.io/docker/pulls/adamus1red/hopm?style=for-the-badge)](https://hub.docker.com/r/adamus1red/hopm)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/adamus1red/docker-hopm/Docker%20Publish?style=for-the-badge)](https://github.com/adamus1red/docker-hopm/actions)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/adamus1red/hopm/latest?style=for-the-badge)](https://hub.docker.com/r/adamus1red/hopm/tags)
[![GitHub](https://img.shields.io/github/license/adamus1red/docker-hopm?style=for-the-badge)](https://github.com/adamus1red/docker-hopm)
## What is HOPM
HOPM (Hybrid Open Proxy Monitor) is an open-proxy monitoring bot designed to
monitor an individual server (all servers on the network have to run their own
bot if the IRCD does not support `farconnect` user mode) with a local
operator {} block and monitor connections. When a client connects to a server,
HOPM will scan the connection for insecure proxies. Insecure proxies are
determined by attempting to connect the proxy back to another host (usually the
IRC server in question).

# Configuration

The HOPM refference config can be found [offical HOPM reference config](https://github.com/ircd-hybrid/hopm/blob/master/doc/reference.conf) this should be mounted at `/hopm/hopm.conf`

A standard HOPM configuration should work without modification and no special changes are needed. Please note that the `vhost` option will probably be ignored unless you do some fancy docker networking which is beyond the scope of this readme.

# Getting Started

## Docker

HOPM is deployed via docker image like so:

```
docker run -d --name hopm \
  -v /path/to/file/hopm.conf:/hopm/hopm.conf \
  adamus1red/hopm:latest
```

or via docker-compose:

[Official Example](https://github.com/adamus1red/docker-hopm/blob/main/docker-compose.yml)

# Multi-Arch builds

In the works but currently if [gcc docker](https://hub.docker.com/_/gcc) supports it then it's fairly easy to build using the docker-compose above.

# Contributing

All contributions are welcome! Contributing guidelines are in the works
