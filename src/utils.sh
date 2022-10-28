#!/bin/bash

export_image_variables() {
    export IMAGE_NAME=$1
    export IMAGE_TAG=$2

    if [ -z "$IMAGE_NAME" ];
    then
        echo "IMAGE_NAME must be provided"
        exit 1
    fi

    if [ -z "$IMAGE_TAG" ];
    then
        export IMAGE_TAG="latest"
    fi

    export IMAGE="$IMAGE_NAME":"$IMAGE_TAG"
    export IMAGE_DIR=layers/"$IMAGE_NAME"."$IMAGE_TAG"
}
