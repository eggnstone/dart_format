#!/bin/bash

# Define file paths
pubspec_file="pubspec.yaml"
version_dart_file="lib/src/Constants/Generated/VersionConstants.dart"

# Extract version numbers from pubspec.yaml. Refuses anything that is not a
# plain MAJOR.MINOR.PATCH stable release - pre-release suffixes like
# `2.0.0-dev1` are rejected on purpose so we don't publish dev versions
# by mistake.
version_line=$(grep -E "^version: " "$pubspec_file")
if [[ ! $version_line =~ ^version:\ ([0-9]+)\.([0-9]+)\.([0-9]+)[[:space:]]*$ ]]; then
    echo "Error: $pubspec_file version is not a plain MAJOR.MINOR.PATCH stable release: '$version_line'" >&2
    echo "       Update pubspec.yaml to a stable version (e.g. 2.0.0) before publishing." >&2
    exit 1
fi
major=${BASH_REMATCH[1]}
minor=${BASH_REMATCH[2]}
patch=${BASH_REMATCH[3]}

# Update version in VersionConstants.dart using a simpler approach
cat "$version_dart_file" | \
    sed "s/MAJOR = [0-9]*;/MAJOR = $major;/" | \
    sed "s/MINOR = [0-9]*;/MINOR = $minor;/" | \
    sed "s/PATCH = [0-9]*;/PATCH = $patch;/" > "$version_dart_file.tmp"
mv "$version_dart_file.tmp" "$version_dart_file"

# Publish to pub.dev
dart pub publish
