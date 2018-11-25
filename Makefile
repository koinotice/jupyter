NAMESPACE = koinotice
IMAGE = notebook
VERSION ?= latest
TAG = v1.0
CONTEXT = .

PWD := ${CURDIR}

PACKAGE_NAME = github.com/koinotice/jupyter
PACKAGE_VERSION ?= $(shell git describe --always --tags)
OS = $(shell uname)

ALL_SRC = $(shell find . -name "*.go" | grep -v -e vendor \
	-e ".*/\..*" \
	-e ".*/_.*" \
	-e ".*/mocks.*" \
	-e ".*/*.pb.go")
ALL_PKGS = $(shell go list $(sort $(dir $(ALL_SRC))) | grep -v vendor)
FMT_SRC = $(shell echo "$(ALL_SRC)" | tr ' ' '\n')
EXT_TOOLS = github.com/axw/gocov/gocov github.com/AlekSi/gocov-xml github.com/matm/gocov-html github.com/golang/mock/mockgen golang.org/x/lint/golint golang.org/x/tools/cmd/goimports
EXT_TOOLS_DIR = ext-tools/$(OS)
DEP_TOOL = $(EXT_TOOLS_DIR)/dep

BUILD_LDFLAGS = -X $(PACKAGE_NAME)/lib/utils.BuildHash=$(PACKAGE_VERSION)
GO_FLAGS = -gcflags '-N -l' -ldflags "$(BUILD_LDFLAGS)"
GO_VERSION = 1.10

REGISTRY ?= koinotice



### Target to build the makisu docker images.
.PHONY: image publish
image:
	docker build -t $(REGISTRY)/notebook:$(PACKAGE_VERSION) -f Dockerfile .
	docker tag $(REGISTRY)/notebook:$(PACKAGE_VERSION) jupyter:$(PACKAGE_VERSION)

publish: image
	docker push $(REGISTRY)/notebook:$(PACKAGE_VERSION)


build:
	docker build -t $(NAMESPACE)/$(IMAGE) .
    #echo "/Users/pelo/go/bin/makisu build -t ${TAG} -dest $(NAMESPACE)/$(IMAGE) ${CONTEXT}"

debug:
	docker run -it $(NAMESPACE)/$(IMAGE) bash

run:
	docker run -it $(NAMESPACE)/$(IMAGE) --env-file env-test

push:
	docker login -e $(DOCKER_EMAIL) -u $(DOCKER_USER) -p $(DOCKER_PASS)
	docker push $(NAMESPACE)/$(IMAGE):$(VERSION)

.PHONY: build