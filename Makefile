PROJECT := cgit-container
NAME   := $(PROJECT)
TAG    := dev-$$(git rev-parse --short HEAD)
IMG    := $(NAME):$(TAG)
LATEST := $(NAME):latest-dev
current_dir = $(shell pwd)

# Dockerfile ARGS
BUILD_DATE      := $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
VCS_REF         := $(shell git rev-parse --short HEAD)

.PHONY: build force-build run push

ARGS= -t $(IMG) --build-arg BUILD_DATE=$(BUILD_DATE) --build-arg VCS_REF=$(VCS_REF) .
BUILD=@docker build
TAGS=@docker tag $(IMG) $(LATEST)
build:
	$(BUILD) $(ARGS)
	$(TAGS)

force-build:
	$(BUILD) --no-cache $(ARGS)
	$(TAGS)

run:
	@docker run -it --rm -p 80:80 -v $(current_dir)/test_repo:/mnt/git --name $(PROJECT) -t $(LATEST)

run-bash:
	@docker run -it --rm --entrypoint /bin/bash --name $(PROJECT)-t $(LATEST) 

push:
	@docker push $(NAME)

test: test-setup run

test-setup:
	mkdir -p test_repo
	cd test_repo && git clone -q --mirror git@gitlab.com:chimbosonic/distiller.git

clean:
	rm -rf test_repo


test-signing: 
	mkdir -p /tmp/$(PROJECT)/
	vault kv get -field=key secrets/$(PROJECT)/cosign > /tmp/$(PROJECT)/cosign.key
	@COSIGN_PASSWORD=$(shell vault kv get -field=password secrets/$(PROJECT)/cosign) cosign sign-blob --key /tmp/$(PROJECT)/cosign.key ./README.md
	rm /tmp/$(PROJECT)/cosign.key