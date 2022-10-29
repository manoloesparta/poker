#!/bin/bash

test_remove_image() {
    # Given
    IMAGE_TO_TEST="busybox"
    IMAGE_TAG="1.34"
    ./main.sh pull $IMAGE_TO_TEST $IMAGE_TAG > /dev/null
    pre_rmi=$(./main.sh images)

    # When
    ./main.sh rmi $IMAGE_TO_TEST $IMAGE_TAG > /dev/null

    # Then
    post_rmi=$(./main.sh images)
    if [[ "$pre_rmi" == "$post_rmi" ]];
    then
        exit 1
    fi
}

test_remove_image
