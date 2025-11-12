#!/bin/bash

set -euo pipefail

names=(
    base-imgs
    # alf-requirements
    # pyalf-requirements
    # pyalf-full
    # pyalf-doc
)

if [[ -n "${REGISTRY_URL:-}" ]]; then
    registry="${REGISTRY_URL}"
elif [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
    # Default to the GitHub Container Registry for CI runs
    registry="ghcr.io/${GITHUB_REPOSITORY,,}"
else
    echo "No registry specified, exiting." >&2
    exit 1
fi
echo "Using registry: ${registry}"

build_date="${BUILD_DATE:-$(date --iso-8601)}"
push_images="${PUSH_IMAGES:-1}"

for name in "${names[@]}"; do
    for directory in "$name"/*; do
        if [[ -d $directory ]]; then
            echo "====== building ${directory} ======"
            docker build --pull -t "${directory}:latest" "$directory"
            docker tag "${directory}:latest" "${directory}:${build_date}"
            docker tag "${directory}:latest" "${registry}/${directory}:${build_date}"
            docker tag "${directory}:latest" "${registry}/${directory}:latest"
            if [[ "${push_images}" == "1" ]]; then
                docker push "${registry}/${directory}:${build_date}"
                docker push "${registry}/${directory}:latest"
            else
                echo "Skipping push for ${registry}/${directory}"
            fi
        fi
    done
done

