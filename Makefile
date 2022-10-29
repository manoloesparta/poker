.PHONY: all
all:
	ln -s main.sh poker

.PHONY: lint
lint:
	shellcheck main.sh src/*.sh tests/*.sh

.PHONY: tests
tests:
	./tests/pull.sh
	./tests/images.sh
	./tests/rmi.sh
	./tests/run.sh
	./tests/ps.sh
	./tests/stop.sh
	./tests/exec.sh
