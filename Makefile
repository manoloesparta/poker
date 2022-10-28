all:
	ln -s main.sh poker

lint:
	shellcheck main.sh src/*.sh tests/*.sh

tests:
	echo "running tests not implemented"

