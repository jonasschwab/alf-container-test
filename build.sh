#!/bin/bash

set -euo pipefail

build_date="${BUILD_DATE:-$(date --iso-8601)}"

names=(
    base-imgs
    alf-requirements
    pyalf-requirements
    pyalf-full
    pyalf-doc
)

push_images="${PUSH_IMAGES:-1}"
if [[ -n "${REGISTRY_URL:-}" ]]; then
    registry="${REGISTRY_URL}"
    echo "Using registry: ${registry}"
elif [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
    # Default to the GitHub Container Registry for CI runs
    registry="ghcr.io/${GITHUB_REPOSITORY,,}"
    echo "Using registry: ${registry}"
else
    echo "No registry specified, skipping push."
    push_images="0"
fi

for name in "${names[@]}"; do
    for directory in "$name"/*; do
        if [[ -d $directory ]]; then
            echo "====== building ${directory} ======"
            build_args=()
            if [[ -n "${registry:-}" ]]; then
                build_args+=(--pull --build-arg "REGISTRY_PREFIX=${registry}/")
            fi
            docker build "${build_args[@]}" -t "${directory}:latest" "$directory"
            docker tag "${directory}:latest" "${directory}:${build_date}"
            if [[ "${push_images}" == "1" ]]; then
                docker tag "${directory}:latest" "${registry}/${directory}:${build_date}"
                docker tag "${directory}:latest" "${registry}/${directory}:latest"
                docker push "${registry}/${directory}:${build_date}"
                docker push "${registry}/${directory}:latest"
            else
                echo "Skipping push for ${directory}"
            fi
        fi
    done
done

