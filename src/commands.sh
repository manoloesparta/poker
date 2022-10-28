#!/bin/bash

poker_pull() {
    # Downlaod image and extract layers in OCI format
    docker pull "$IMAGE"
    skopeo copy docker-daemon:"$IMAGE" oci:layers/"$IMAGE_DIR"

    # Get layers manifest file
    layers_manifest_file=$(jq '.manifests[0].digest' < layers/"$IMAGE_DIR"/index.json) 
    layers_manifest_file_clean=$(echo "$layers_manifest_file" | sed 's/sha256://g' | sed 's/"//g')

    # Find the tars for lower directories
    layers_tars=$(jq '.layers' < layers/"$IMAGE_DIR"/blobs/sha256/"$layers_manifest_file_clean")
    layers_tars_clean=$(echo "$layers_tars" | jq | grep digest | sed 's/    "digest": "sha256://g' | sed 's/",//g')

    # Extract all lower directories
    mkdir -p layers/"$IMAGE_DIR"/directories
    counter=0
    for layer_tar in $layers_tars_clean; do
        echo layers/"$IMAGE_DIR"/directories/"$counter"
        mkdir -p layers/"$IMAGE_DIR"/directories/"$counter"
        tar xf layers/"$IMAGE_DIR"/blobs/sha256/"$layer_tar" -C layers/"$IMAGE_DIR"/directories/"$counter"
        counter=$(echo $counter + 1 | bc)
    done
}

poker_list() {
    ls -1 layers | sed 's/\./:/'
}

poker_run() {
    FRIENDLY_NAME=$1

    if [ -z "$FRIENDLY_NAME" ];
    then
        echo "FRIENDLY_NAME must be provided"
        exit 1
    fi

    # Check that layers exist

    # Mount the overlay filesystem

    echo "running container: $FRIENDLY_NAME with $IMAGE"
}