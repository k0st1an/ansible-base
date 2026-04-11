.PHONY: build flow

IMAGE_NAME=k0st1an/ansible-base:13

build:
	docker build --no-cache -t ${IMAGE_NAME} .

flow:
	docker run -it --rm -v $(PWD):/ansible ${IMAGE_NAME} bash
