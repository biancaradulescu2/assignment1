#! /bin/bash

START_VERSION=$(( $1 + 1 ))


for (( i=START_VERSION; i<=15; i++ )); do
    VERSION_TAG="v$i"
    echo "Version: $VERSION_TAG"
    docker tag prod biancaradulescu/assignment1_prod:$VERSION_TAG
    docker push biancaradulescu/assignment1_prod:$VERSION_TAG
done

echo "Done"