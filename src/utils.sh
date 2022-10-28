#!/bin/bash

export_image_variables() {
    export IMAGE_NAME=$1
    export IMAGE_TAG=$2

    if [ -z "$IMAGE_TAG" ];
    then
        export IMAGE_TAG="latest"
    fi

    export IMAGE=$IMAGE_NAME:$IMAGE_TAG
    export IMAGE_DIR=$IMAGE_NAME.$IMAGE_TAG
}
