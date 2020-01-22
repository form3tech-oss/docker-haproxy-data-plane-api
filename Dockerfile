ARG HAPROXY_VERSION

FROM debian:latest AS builder
ARG HAPROXY_DATA_PLANE_API_VERSION
ADD https://github.com/haproxytech/dataplaneapi/releases/download/v${HAPROXY_DATA_PLANE_API_VERSION}/dataplaneapi /dataplaneapi
RUN chmod a+x /dataplaneapi

FROM haproxytech/haproxy-alpine:${HAPROXY_VERSION}
COPY --from=builder /dataplaneapi /dataplaneapi
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
