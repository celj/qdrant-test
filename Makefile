CONFIG_DIR := config/development.yml
IMAGE := dd3qdrant
PORT := 6333

RUN := docker run --rm -it \
	-p $(PORT):$(PORT) \
	-v `pwd`/config:/qdrant/config \
	$(IMAGE)

clean:
	docker image prune -f

image:
	docker build -t $(IMAGE) .

run:
	$(RUN) ./qdrant --config-path $(CONFIG_DIR)

shell:
	$(RUN) /bin/bash
