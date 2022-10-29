#!/bin/bash

test_check_running_containers() {
    # Given
    IMAGE_TO_TEST="busybox"
    ./main.sh pull $IMAGE_TO_TEST > /dev/null
    CONTAINER_NAME="test"
    ./main.sh run $CONTAINER_NAME $IMAGE_TO_TEST > /dev/null

    # When
    output=$(./main.sh ps)

    # Then
    echo "$output" | grep $CONTAINER_NAME > /dev/null

    # Cleanup
    sudo umount containers/$CONTAINER_NAME/mount
    rm -rf container/$CONTAINER_NAME
    rm -rf layers/$IMAGE_TO_TEST.latest
}

test_check_running_containers