#! /bin/bash

START_VERSION=$(( $1 + 1 ))


for (( i=START_VERSION; i<=15; i++ )); do
    VERSION_TAG="v$i"
    echo "Version: $VERSION_TAG"
    docker tag test biancaradulescu/assignment1_test:$VERSION_TAG
    docker push biancaradulescu/assignment1_test:$VERSION_TAG
done

echo "Done"