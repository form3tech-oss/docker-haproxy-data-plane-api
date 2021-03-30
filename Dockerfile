ARG HAPROXY_VERSION

FROM golang:1 AS builder
ARG HAPROXY_DATA_PLANE_API_VERSION
RUN git clone https://github.com/haproxytech/dataplaneapi.git $GOPATH/src/github.com/haproxytech/dataplaneapi
WORKDIR $GOPATH/src/github.com/haproxytech/dataplaneapi
RUN git checkout ${HAPROXY_DATA_PLANE_API_VERSION}
RUN make build
RUN cp build/dataplaneapi /dataplaneapi

FROM haproxytech/haproxy-alpine:${HAPROXY_VERSION}
COPY --from=builder /dataplaneapi /dataplaneapi
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
