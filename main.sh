#!/bin/bash

source src/utils.sh
source src/commands.sh

usage() {
    echo
    echo "Usage: poker COMMAND "
    echo
    echo "Comands:"
    echo -e "  pull:      Download image layers from the docker registry"
    echo -e "  images:    List the locally available images"
    echo -e "  rmi:       Remove local image"
    echo -e "  run:       Run commands inside a running container"
    echo -e "  ps:        List running containers"
    echo -e "  stop:      Stop running containers"
    echo
}

mkdir -p containers layers

case "$1" in
    pull)
        IMAGE_NAME=$2
        IMAGE_TAG=$3
        export_image_variables "$IMAGE_NAME" "$IMAGE_TAG"
        poker_pull
    ;;
    images)
        poker_list_images
    ;;
    rmi)
        IMAGE_NAME=$2
        IMAGE_TAG=$3
        export_image_variables "$IMAGE_NAME" "$IMAGE_TAG"
        poker_remove_image 
    ;;
    run)
        IMAGE_NAME=$3
        IMAGE_TAG=$4
        export_image_variables "$IMAGE_NAME" "$IMAGE_TAG"
        CONTAINER_NAME=$2
        export_container_variables "$CONTAINER_NAME"
        poker_run 
    ;;
    ps)
        poker_list_running_containers
    ;;
    stop)
        CONTAINER_NAME=$2
        export_container_variables "$CONTAINER_NAME"
        poker_stop_container
    ;;
    hello)
        echo "hello there, poker"
    ;;
    ping)
        echo "pong"
    ;;
    *)
        usage
    ;;
esac
