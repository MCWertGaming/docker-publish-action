#!/usr/bin/env sh

echo "======================="
echo "Docker Publish plugin"
echo "Thank you for using it!"
echo "======================="
echo ""

# check if the user tries to open a shell

if [[ "$1" == "bash" || "$1" == "/usr/bin/bash" || "$1" == "/bin/bash" || "$1" == "sh" || "$1" == "/bin/sh" || "$1" == "/usr/bin/sh" ]]; then
    echo "Here is your shell!"
    /usr/bin/env sh
elif [[ "$1" == "help" ]]; then
    echo "This container is configured using environemt variables!"
    echo "See this for a reference:"
    echo "REGISRY_USER     <- User for logging in into the registry       (Required if DO_PUSH is set to true)"
    echo "REGISTRY_PASS    <- Password for logging in into the registry   (Required if DO_PUSH is set to true)"
    echo "REPOSITORY       <- Repository this script should push into     (Optional, defaults to dockerhub)"
    echo "REGISTRY         <- Registry used for logging in and pushing to (Optional, defaults to dockerhub)"
    echo "DO_PUSH          <- Enables / disables Pushing into the given registry (Optional, defaults to 'false')"
    echo "DISABLE_BUILDKIT <- Disables docker-buildkit                    (Optional, defaults to true)"
    echo ""
    echo "Out of the box supported registries are:"
    echo "- dockerhub (https://hub.docker.com)"
    echo "- quay (https://quay.io)"
    echo "To use them, just use their name for the 'REGISTRY' environment variable."
    echo ""
    echo "For more informations visit:"
    echo "https://github.com/mcwertgaming/docker-publish-action"
    echo ""
    echo "This is free software licensed under MIT. To learn more visit:"
    echo "https://github.com/MCWertGaming/docker-publish-action/blob/main/LICENSE"
    echo ""
    echo "Thank you using this software!"
elif [[ "$1" != "" ]]; then
    echo "Invalid input! Configuration is done using environment variables."
    echo "Use help for more informations."
else
    # run the actual script
    /run.sh
fi
