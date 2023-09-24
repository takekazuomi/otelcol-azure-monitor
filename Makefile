.DEFAULT_GOAL := help

.PHONY: help setup publish build builder generate

CR_NAME		?= ghcr.io
CR_USER		?= takekazuomi
IMAGE_NAME 	?= otelcol-azure-monitor 

KO_DOCKER_REPO ?= $(CR_NAME)/$(CR_USER)

TAG_VERSION ?= v0.85.0

help: ## show this message
	@grep -E '^[a-zA-Z0-9_.-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-8s\033[0m %s\n", $$1, $$2}'

setup:	## setup 
	go install go.opentelemetry.io/collector/cmd/builder@latest
	go install github.com/google/ko@latest

publish: generate
publish: ## ko build
	echo $${CR_PAT} | ko login ghcr.io -u $(CR_USER) --password-stdin
	cd ./gen && env KO_DOCKER_REPO=$(KO_DOCKER_REPO)/$(IMAGE_NAME) ko build --bare -t $(TAG_VERSION) -t latest .

build: ## ko build (ko.local)
	$(MAKE) publish KO_DOCKER_REPO=ko.local

generate: ## generate
	builder --skip-compilation --config=otelcol-builder.yaml

