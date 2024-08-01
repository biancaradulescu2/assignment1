#! /bin/bash

version=$(cat version.txt)
echo "Current version: $version"

# Increment the version number
IFS='.' read -r -a version_parts <<< "$version"
((version_parts[2]++))
new_version="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}"
echo "New version: $new_version"

echo $new_version > version.txt
