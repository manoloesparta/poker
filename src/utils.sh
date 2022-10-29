#!/bin/bash

export_image_variables() {
    IMAGE_NAME=$1
    IMAGE_TAG=$2

    if [ -z "$IMAGE_NAME" ];
    then
        echo "IMAGE_NAME must be provided"
        exit 1
    fi

    if [ -z "$IMAGE_TAG" ];
    then
        IMAGE_TAG="latest"
    fi

    export IMAGE="$IMAGE_NAME:$IMAGE_TAG"
    export IMAGE_DIR="layers/$IMAGE_NAME.$IMAGE_TAG"
}


export_container_variables() {
    CONTAINER_NAME=$1

    if [ -z "$CONTAINER_NAME" ];
    then
        echo "CONTAINER_NAME must be provided"
        exit 1
    fi

    export CONTAINER=$CONTAINER_NAME
    export CONTAINER_DIR="containers/$CONTAINER_NAME"
}