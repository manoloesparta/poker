#!/bin/bash

source src/commands.sh

usage() {
    echo
    echo "Usage: bocker COMMAND "
    echo
    echo "Comands:"
    echo -e "  pull:\t\t Download image layers from the docker registry"
    echo -e "  run:\t\t Run commands inside running container"
    echo -e "  images:\t List the locally available images"
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
        bocker_pull "$2" "$3"
    ;;
    hello)
        echo "hello there, bocker"
    ;;
    *)
        usage
    ;;
esac