.PHONY: build flow

IMAGE_NAME=k0st1an/ansible-base:10

build:
	docker build -t ${IMAGE_NAME} .

flow:
	docker run -it --rm -v $(PWD):/ansible ${IMAGE_NAME} bash
