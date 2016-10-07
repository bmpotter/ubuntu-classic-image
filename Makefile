SHELL = /bin/bash -e

ARCH = $(shell ./tools/arch-tag)
COMPILE_CLEAN ?= clean
IMAGE_OUTPUT_DIR ?= /mnt/extra

all: sd-image

clean:
	-rm -rf $(IMAGE_OUTPUT_DIR)/horizon-rpi2-*

deep-clean:
	tools/deep-clean CLEAN

repo-fork-sync:
	tools/repo-fork-sync

sd-image:
	bash -x sd-image/package-sd-image $(IMAGE_OUTPUT_DIR)

push-sd-image:
	cd $(IMAGE_OUTPUT_DIR); \
		export IMG=$$(ls ./horizon-rpi2-*.img); \
		zip -8 $$IMG.zip $$IMG; \
		swift upload --verbose colonus $$IMG.zip

.PHONY: clean deep-clean repo-fork-sync sd-image push-sd-image