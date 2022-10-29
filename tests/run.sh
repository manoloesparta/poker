#!/bin/bash

test_run_container() {
    # Given
    IMAGE_TO_TEST="nginx"
    ./main.sh pull $IMAGE_TO_TEST > /dev/null

    # When
    CONTAINER_NAME="test"
    ./main.sh run $CONTAINER_NAME $IMAGE_TO_TEST > /dev/null

    # Then
    stat containers > /dev/null 
    stat containers/$CONTAINER_NAME > /dev/null
    stat containers/$CONTAINER_NAME/mount > /dev/null
    stat containers/$CONTAINER_NAME/work > /dev/null
    mountpoint -q containers/$CONTAINER_NAME/mount

    # Cleanup
    sudo umount containers/$CONTAINER_NAME/mount
    sudo rm -rf containers/$CONTAINER_NAME
}

test_name_already_take() {
    # Given
    IMAGE_TO_TEST="nginx"
    ./main.sh pull $IMAGE_TO_TEST > /dev/null
    CONTAINER_NAME="test"
    ./main.sh run $CONTAINER_NAME $IMAGE_TO_TEST > /dev/null

    # When
    output=$(./main.sh run $CONTAINER_NAME)

    # Then
    echo "$output" | grep taken > /dev/null

    # Cleanup
    sudo umount containers/$CONTAINER_NAME/mount
    sudo rm -rf containers/$CONTAINER_NAME
}

test_run_container
test_name_already_take
