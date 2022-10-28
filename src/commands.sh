#!/bin/bash

poker_pull() {
    IMAGE_NAME=$1
    IMAGE_TAG=$2

    if [ -z $IMAGE_TAG ];
    then
        IMAGE_TAG="latest"
    fi

    image=$IMAGE_NAME:$IMAGE_TAG
    if [ -d $image ];
    then
        rm -rf layers/${image}/*
    else
        mkdir layers/$image
    fi

    docker pull $image

    layers=$(docker inspect $image | jq '.[0].RootFS.Layers')
    clean_layers=$(echo $layers | sed 's/"sha256://g' | sed 's/",//g' | sed 's/"//g' | sed 's/\[//g' | sed 's/]//g' | tr ' ' '\n')

    docker_layers_path=/var/lib/docker/image/overlay2/distribution/v2metadata-by-diffid/sha256

    echo $clean_layers

    echo $clean_layers | tr ' ' '\n'  | while read -r layer; do mv ${docker_layers_path}/${layer} layers/$image; done
}
