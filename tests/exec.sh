#!/bin/bash

test_exec_in_container() {
    # Given
    IMAGE_TO_TEST="busybox"
    ./main.sh pull $IMAGE_TO_TEST > /dev/null
    CONTAINER_NAME="test"
    ./main.sh run $CONTAINER_NAME $IMAGE_TO_TEST > /dev/null
    pre_stop=$(./main.sh ps)

    # When
    ./main.sh exec $CONTAINER_NAME "touch botita"

    # Then
    stat containers/"$CONTAINER_NAME"/upper/botita > /dev/null
    image=$(cat containers/"$CONTAINER_NAME"/image)
    result=$(find layers/"$IMAGE_TO_TEST".latest/directories -name botita)
    if [ ! -z $result ];
    then
        exit 1
    fi

    # Cleanup
    ./main.sh stop $CONTAINER_NAME
    rm -rf layers/$IMAGE_TO_TEST.latest
}

test_exec_in_container
