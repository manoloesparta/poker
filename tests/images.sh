#!/bin/bash

test_list_images() {
    # Given
    IMAGE_TO_TEST="busybox"
    IMAGE_TAG="1.34"
    ./main.sh pull $IMAGE_TO_TEST $IMAGE_TAG > /dev/null

    # When
    output=$(./main.sh images)

    # Then
    echo "$output" | grep $IMAGE_TO_TEST:$IMAGE_TAG > /dev/null

    # Cleanup
    rm -rf layers/$IMAGE_TO_TEST.$IMAGE_TAG
}

test_list_images
