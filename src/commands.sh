#!/bin/bash

poker_pull() {
    IMAGE_NAME=$1
    IMAGE_TAG=$2

    if [ -z $IMAGE_TAG ];
    then
        IMAGE_TAG="latest"
    fi

    image=$IMAGE_NAME:$IMAGE_TAG
    image_dir=$IMAGE_NAME.$IMAGE_TAG

    docker pull $image

    skopeo copy docker-daemon:$image oci:layers/$image_dir
}
