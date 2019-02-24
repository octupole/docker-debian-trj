IMAGE_NAME="debian-trj"
TAG="latest"
CONTAINER_NAME="debian-trj"

.PHONY: all build

all: build

build:
	docker build --tag "octupole/${IMAGE_NAME}:${TAG}" .

start:
	docker run -d --rm -it \
		--name ${CONTAINER_NAME} \
		"octupole/${IMAGE_NAME}:${TAG}" \
		tail -f /dev/null

term:
	docker exec -it ${CONTAINER_NAME} /bin/bash


stop:
	docker kill ${CONTAINER_NAME}
