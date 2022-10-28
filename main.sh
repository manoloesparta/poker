#!/bin/bash

source src/commands.sh

usage() {
    echo
    echo "Usage: poker COMMAND "
    echo
    echo "Comands:"
    echo -e "  pull:      Download image layers from the docker registry"
    echo -e "  run:       Run commands inside running container"
    echo -e "  images:    List the locally available images"
    echo
}


if [ ! -d layers ];
then
    mkdir layers
fi

case "$1" in
    pull)
        IMAGE_NAME=$2
        IMAGE_TAG=$3
        poker_pull "$2" "$3"
    ;;
    hello)
        echo "hello there, poker"
    ;;
    *)
        usage
    ;;
esac
