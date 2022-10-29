#!/bin/bash

poker_pull() {
    echo "Pulling $IMAGE from docker hub"

    # Downlaod image and extract layers in OCI format
    docker pull "$IMAGE" > /dev/null
    skopeo copy "docker-daemon:$IMAGE" "oci:$IMAGE_DIR" > /dev/null

    # Get layers manifest file
    layers_manifest_file=$(jq '.manifests[0].digest' < "$IMAGE_DIR/index.json") 
    layers_manifest_file_clean=$(echo "$layers_manifest_file" | sed 's/sha256://g' | sed 's/"//g')

    # Find the tars for lower directories
    layers_tars=$(jq '.layers' < "$IMAGE_DIR/blobs/sha256/$layers_manifest_file_clean")
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
    echo "IMAGES"
    echo
    ls -1 layers | sed 's/\./:/'
}

poker_remove_image() {
    if [ -d "$IMAGE_DIR" ];
    then
        rm -rf "$IMAGE_DIR"
        echo "$IMAGE" removed
    fi
}

poker_run() {
    # Check that image exist
    if [ ! -d "$IMAGE_DIR" ];
    then
        echo "Image $IMAGE has not been pulled"
        exit 1
    fi 

    # Check CONTAINER_NAME is not taken
    if [ -d "$CONTAINER_DIR" ];
    then
        echo "Unable to create container $CONTAINER_NAME is already taken"
        exit 1
    fi

    # Get the lower directories
    lowerdirs=""
    for file in "$IMAGE_DIR"/directories/*;
    do
        lowerdirs+=$file:
    done
    lowerdirs=${lowerdirs::-1}

    # Mount the overlay filesystem
    mkdir -p "$CONTAINER_DIR"/{upper,work,mount}
    echo "$IMAGE" > "$CONTAINER_DIR/image"
    sudo mount -t overlay -o rw,lowerdir="$lowerdirs",upperdir="$CONTAINER_DIR"/upper,workdir="$CONTAINER_DIR"/work overlay "$CONTAINER_DIR"/mount

    echo "Container '$CONTAINER_NAME' is running"
}

poker_list_running_containers() {
    echo "RUNNING CONTAINERS"
    echo

    for container in $(ls -1 containers);
    do
        image=$(cat containers/"$container"/image)
        echo "NAME $container IMAGE $image"
    done
}

poker_stop_container() {
    # Check that container exist
    if [ ! -d "$CONTAINER_DIR" ];
    then
        echo "Container $CONTAINER does not exist"
        exit 1
    fi 

    # Umount container filesystem
    sudo umount $CONTAINER_DIR/mount

    # Delete container directory
    sudo rm -rf $CONTAINER_DIR
}

poker_exec_container() {
    COMMAND=$@

    # Check that container exist
    if [ ! -d "$CONTAINER_DIR" ];
    then
        echo "Container $CONTAINER does not exist"
        exit 1
    fi 

    # Go into chroot and execute command
    sudo chroot $CONTAINER_DIR/mount $COMMAND
}
