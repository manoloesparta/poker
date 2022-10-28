#!/bin/bash

test_pull_latest_image() {
    # Given 
    IMAGE_TO_TEST=nginx

    # When
    ./main.sh pull $IMAGE_TO_TEST

    # Then
    stat layers
    stat layers/$IMAGE_TO_TEST.latest
    stat layers/$IMAGE_TO_TEST.latest/directories
    stat layers/$IMAGE_TO_TEST.latest/directories/0
}

test_pull_specific_image() {
    # Given 
    IMAGE_TO_TEST=nginx
    IMAGE_TAG=1.23

    # When
    ./main.sh pull $IMAGE_TO_TEST $IMAGE_TAG

    # Then
    stat layers
    stat layers/$IMAGE_TO_TEST.$IMAGE_TAG
    stat layers/$IMAGE_TO_TEST.$IMAGE_TAG/directories
    stat layers/$IMAGE_TO_TEST.$IMAGE_TAG/directories/0
}

test_pull_latest_image
test_pull_specific_image
