#!/bin/bash

# Define file paths
pubspec_file="pubspec.yaml"
version_dart_file="lib/src/Constants/Generated/VersionConstants.dart"

# Extract version numbers from pubspec.yaml
version_line=$(grep -E "version: [0-9]+\.[0-9]+\.[0-9]+" "$pubspec_file")
if [[ $version_line =~ version:\ ([0-9]+)\.([0-9]+)\.([0-9]+) ]]; then
    major=${BASH_REMATCH[1]}
    minor=${BASH_REMATCH[2]}
    patch=${BASH_REMATCH[3]}
else
    echo "Error: Could not extract version from $pubspec_file"
    exit 1
fi

# Update version in VersionConstants.dart using a simpler approach
cat "$version_dart_file" | \
    sed "s/MAJOR = [0-9]*;/MAJOR = $major;/" | \
    sed "s/MINOR = [0-9]*;/MINOR = $minor;/" | \
    sed "s/PATCH = [0-9]*;/PATCH = $patch;/" > "$version_dart_file.tmp"
mv "$version_dart_file.tmp" "$version_dart_file"

# Publish to pub.dev
dart pub publish
