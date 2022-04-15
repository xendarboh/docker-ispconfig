SHELL := /bin/bash

# https://unix.stackexchange.com/questions/235223/makefile-include-env-file
include .env
export
MAKEFILE_LIST = Makefile

# https://blog.testdouble.com/posts/2017-04-17-makefile-usability-tips/#step-3-parse-annotations
help: ## print this help message with some nifty mojo
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: build-support ## build docker images
	docker-compose --profile build build

build-rebuild: build-support ## build docker images with --no-cache
	docker-compose --profile build build --no-cache

build-support: ## build and start services that support the build process
	docker-compose --profile build-support up -d

run: ## run services (log to console)
	docker-compose --profile run up

run-upd: ## run services as daemon
	docker-compose --profile run up -d

run-down: ## stop services
	docker-compose --profile run down

clean: run-down ## prune docker images/containers
	docker container prune -f
	docker images prune
	docker images | awk '/none/{print $$3}' | xargs docker rmi || true

.PHONY: \
	help \
	build \
	build-rebuild \
	build-support \
	run \
	run-upd \
	run-down \
	clean \
