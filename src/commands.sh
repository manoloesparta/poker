#!/bin/bash

poker_pull() {
    echo "Pulling "$IMAGE" from docker hub"

    # Downlaod image and extract layers in OCI format
    docker pull "$IMAGE" > /dev/null
    skopeo copy docker-daemon:"$IMAGE" oci:"$IMAGE_DIR" > /dev/null

    # Get layers manifest file
    layers_manifest_file=$(jq '.manifests[0].digest' < "$IMAGE_DIR"/index.json) 
    layers_manifest_file_clean=$(echo "$layers_manifest_file" | sed 's/sha256://g' | sed 's/"//g')

    # Find the tars for lower directories
    layers_tars=$(jq '.layers' < "$IMAGE_DIR"/blobs/sha256/"$layers_manifest_file_clean")
    layers_tars_clean=$(echo "$layers_tars" | jq | grep digest | sed 's/    "digest": "sha256://g' | sed 's/",//g')

    # Extract all lower directories
    mkdir -p "$IMAGE_DIR"/directories
    counter=0
    for layer_tar in $layers_tars_clean; do
        mkdir -p "$IMAGE_DIR"/directories/"$counter"
        tar xf "$IMAGE_DIR"/blobs/sha256/"$layer_tar" -C "$IMAGE_DIR"/directories/"$counter"
        counter=$(echo $counter + 1 | bc)
    done

    echo "Successfully downloaded"
}

poker_list_images() {
    echo "Images"
    echo
    ls -1 layers | sed 's/\./:/'
}

poker_remove_image() {
    if [ -d $IMAGE_DIR ];
    then
        rm -rf $IMAGE_DIR
        echo "$IMAGE" removed
    fi
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