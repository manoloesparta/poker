#!/bin/bash

test_pull_latest_image() {
    # Given 
    IMAGE_TO_TEST=nginx

    # When
    ./main.sh pull $IMAGE_TO_TEST > /dev/null

    # Then
    stat layers > /dev/null
    stat layers/$IMAGE_TO_TEST.latest > /dev/null
    stat layers/$IMAGE_TO_TEST.latest/directories > /dev/null
    stat layers/$IMAGE_TO_TEST.latest/directories/0 > /dev/null
}

test_pull_specific_image() {
    # Given 
    IMAGE_TO_TEST=nginx
    IMAGE_TAG=1.23

    # When
    ./main.sh pull $IMAGE_TO_TEST $IMAGE_TAG > /dev/null

    # Then
    stat layers > /dev/null
    stat layers/$IMAGE_TO_TEST.$IMAGE_TAG > /dev/null
    stat layers/$IMAGE_TO_TEST.$IMAGE_TAG/directories > /dev/null
    stat layers/$IMAGE_TO_TEST.$IMAGE_TAG/directories/0 > /dev/null
}

test_pull_latest_image
test_pull_specific_image
