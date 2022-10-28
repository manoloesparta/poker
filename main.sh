#!/bin/bash

source src/utils.sh
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
        export_image_variables "$IMAGE_NAME" "$IMAGE_TAG"
        poker_pull
    ;;
    run)
        IMAGE_NAME=$2
        IMAGE_TAG=$3
        export_image_variables "$IMAGE_NAME" "$IMAGE_TAG"
        FRIENDLY_NAME=$4
        poker_run "$FRIENDLY_NAME"
    ;;
    hello)
        echo "hello there, poker"
    ;;
    *)
        usage
    ;;
esac
