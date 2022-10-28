.PHONY: all
all:
	ln -s main.sh poker

.PHONY: lint
lint:
	shellcheck main.sh src/*.sh tests/*.sh

.PHONY: tests
tests:
	rm -rf layers
	./tests/pull.sh
	rm -rf layers
	./tests/images.sh
	rm -rf layers
	./tests/rmi.sh
