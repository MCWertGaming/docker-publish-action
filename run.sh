#!/usr/bin/env sh

# docker build script by Damon Leven
# Licensed under the terms of the MIT Lisence:
# https://github.com/mcwertgaming/docker-publish-action/main/LICENSE
#
# The following ENV's can be used using this script:
# REGISRY_USER     <- User for logging in into the registry       (Required if DO_PUSH is set to true)
# REGISTRY_PASS    <- Password for logging in into the registry   (Required if DO_PUSH is set to true)
# REPOSITORY       <- Repository this script should push into     (Optional, defaults to dockerhub)
# REGISTRY         <- Registry used for logging in and pushing to (Optional, defaults to dockerhub)
# DO_PUSH          <- Enables / disables Pushing into the given registry (Optional, defaults to "false")
# DISABLE_BUILDKIT <- Disables docker-buildkit                    (Optional, defaults to true)
#
# For more informations visit:
# https://github.com/mcwertgaming/docker-publish-action

set -e

echo ""
echo "Setting default values"
echo "======================"
# set default options
if [[ "$REGISTRY" == "dockerhub" || "$REGISTRY" == "DockerHub" || "$REGISTRY" == "Dockerhub"  || "$REGISTRY" == "" ]]; then
    echo "Dockerhub login detected! switching to dockerhub registry..."
    export REGISTRY=docker.io
    # TODO: implement
elif [[ "$REGISTRY" == "quay" || "$REGISTRY" == "Quay"  ]]; then
    echo "Dockerhub login detected! switching to dockerhub registry..."
    export REGISTRY=quay.io
    # TODO: Implement
fi
# enable buildkit if not specified
if [[ "$DISABLE_BUILDKIT" == "" ]]; then
    echo "Activating docker buildkit!"
    DISABLE_BUILDKIT=false
fi
# disable push if not specified
if [[ "$DO_PUSH" == "" ]]; then
    echo "Disabling docker push!"
    DO_PUSH=false
fi

echo ""
echo "Checking for wrong input"
echo "========================"
# check for missing input
if [[ "$REGISTRY_USER" == "" && "$DO_PUSH" == "true" ]]; then
    echo "No username defined!"
    echo "exiting..."
    exit 1
elif [[ "$REGISTRY_PASS" == "" && "$DO_PUSH" == "true" ]]; then
    echo "No password defined!"
    echo "exiting..."
    exit 1
elif [[ "$DISABLE_BUILDKIT" != "" && "$DISABLE_BUILDKIT" != "false" && "$DISABLE_BUILDKIT" != "true" ]]; then
    echo "invalid value in DISABLE_BUILDKIT!"
    echo "Allowed values are: true, false, <no value> ."
    echo "Exiting..."
    exit 1
elif [[ "$REPOSITORY" == "" && "$DO_PUSH" == "true" ]]; then
    echo "Push would be performed but no destination repository given."
    echo "Exiting..."
    exit 1
else
    echo "Input is valid!"
fi

echo ""
echo "Setting up buildkit"
echo "==================="

if [[ "$DISABLE_BUILDKIT" == "true" ]]; then
    echo "Docker buildkit is disabled! Please note that this feature improves docker containers overall."
    echo "See more at: https://docs.docker.com/develop/develop-images/build_enhancements/"
    export DOCKER_BUILDKIT=0
elif [[ "$DISABLE_BUILDKIT" == "false" ]]; then
    echo "Docker buildkit enabled! Your docker containers are optmized!"
    echo "See more at: https://docs.docker.com/develop/develop-images/build_enhancements/"
    export DOCKER_BUILDKIT=1
fi

echo ""
echo "Building container image"
echo "========================"
# don't use cached layers and always pull never base images
docker build . \
    --tag $REPOSITORY \
    --no-cache \
    --pull

if [[ "$DO_PUSH" == "true" ]]; then
    echo ""
    echo "Performing auto login into your docker registry..."
    echo "=================================================="
    echo $REGISTRY_PASS | docker login \
        --username $REGISTRY_USER \
        --password-stdin \
        $REGISTRY_URL

    echo ""
    echo "Pushing the image to your registry..."
    echo "====================================="
    docker push $REPOSITORY

    echo ""
    echo "Build and Push finished successfully!"
    echo "========="
else
    echo ""
    echo "Push skipped!"
    echo "Build finished successfully!"
fi
