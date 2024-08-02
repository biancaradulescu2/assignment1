#!/bin/bash


REPOSITORY=$1
DOCKER_REGISTRY_URL="https://registry-1.docker.io/v2"
TOKEN=$(curl -s "$DOCKER_REGISTRY_URL/token?service=registry.docker.io&scope=repository:$REPOSITORY:pull" | jq -r .token)

# Obține lista de tag-uri pentru repository-ul 
TO_DELETE=$(curl -s -H "Authorization: Bearer $TOKEN" "$DOCKER_REGISTRY_URL/$REPOSITORY/tags/list" | jq -r '.tags[]' | sort | head -n 4)
echo "$TO_DELETE"

# for TAG in $TO_DELETE; do
#     # Obține digestul imaginii
#     DIGEST=$(curl -s -H "Authorization: Bearer $TOKEN" "$DOCKER_REGISTRY_URL/$REPOSITORY/manifests/$TAG" | jq -r .config.digest)

#     # Șterge imaginea
#     curl -s -X DELETE -H "Authorization: Bearer $TOKEN" "$DOCKER_REGISTRY_URL/$REPOSITORY/manifests/$DIGEST"
# done


