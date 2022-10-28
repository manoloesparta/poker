.PHONY: all
all:
	ln -s main.sh poker

.PHONY: lint
lint:
	shellcheck main.sh src/*.sh tests/*.sh

.PHONY: tests
tests:
	./tests/pull.sh
