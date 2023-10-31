ENV ?= development
CONFIG_DIR := /qdrant/config/$(ENV).yaml
IMAGE := dd3qdrant
PORT := 6333
RUN := docker run -d \
        -p $(PORT):$(PORT) \
        -v `pwd`/config:/qdrant/config \
        -v `pwd`/db_storage:/qdrant/storage \
        -e RUN_MODE=${ENV} \
        --name qdrant-$(ENV) \
        $(IMAGE)

clean:
        docker rm qdrant-$(ENV)
        docker image prune -f

image:
        docker build -t $(IMAGE) .

run:
        $(RUN) ./qdrant #  --config-path $(CONFIG_DIR)

shell:
        $(RUN) /bin/bash

test:
        echo $(CONFIG_DIR)

log:
        docker logs -f qdrant-$(ENV)

kill:
        docker stop qdrant-$(ENV)
        docker rm qdrant-$(ENV)

bash:
        docker exec -it qdrant-$(ENV) /bin/bash
