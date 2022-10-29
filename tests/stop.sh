#!/bin/bash

test_stop_container() {
    # Given
    IMAGE_TO_TEST="busybox"
    ./main.sh pull $IMAGE_TO_TEST > /dev/null
    CONTAINER_NAME="test"
    ./main.sh run $CONTAINER_NAME $IMAGE_TO_TEST > /dev/null
    pre_stop=$(./main.sh ps)

    # When
    ./main.sh stop $CONTAINER_NAME

    # Then
    pos_stop=$(./main.sh ps)
    if [[ "$pre_stop" == "$pos_stop" ]];
    then
        exit 1
    fi

    # Cleanup
    rm -rf layers/$IMAGE_TO_TEST.latest
}

test_stop_container