SHELL := /bin/bash

ROOT := $(shell git rev-parse --show-toplevel)

HAPROXY_VERSION ?= 2.1.2
HAPROXY_DATA_PLANE_API_VERSION ?= 1.2.4

VERSION ?= $(HAPROXY_VERSION)-$(HAPROXY_DATA_PLANE_API_VERSION)

DOCKER_IMG ?= form3tech/haproxy-data-plane-api
DOCKER_TAG ?= $(VERSION)

.PHONY: docker.build
docker.build:
	docker build --build-arg HAPROXY_VERSION=$(HAPROXY_VERSION) --build-arg HAPROXY_DATA_PLANE_API_VERSION=$(HAPROXY_DATA_PLANE_API_VERSION) -t $(DOCKER_IMG):$(DOCKER_TAG) $(ROOT)

.PHONY: docker.push
docker.push: docker.build
	echo "$(DOCKER_PASSWORD)" | docker login -u "$(DOCKER_USERNAME)" --password-stdin
	docker push $(DOCKER_IMG):$(DOCKER_TAG)
