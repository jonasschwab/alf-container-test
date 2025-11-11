#!/bin/bash

set -euo pipefail

names=(
alf-requirements
pyalf-requirements
pyalf-full
pyalf-doc
)

if [[ -n "${REGISTRY_URL:-}" ]]; then
    registry="${REGISTRY_URL}"
elif [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
    # Default to the GitHub Container Registry for CI runs
    registry="ghcr.io/${GITHUB_REPOSITORY,,}"
else
    registry="git.physik.uni-wuerzburg.de:25812/alf/alf_docker"
fi
echo "Using registry: ${registry}"

build_date="${BUILD_DATE:-$(date --iso-8601)}"
push_images="${PUSH_IMAGES:-1}"

mapfile -t list < <(grep FROM alf-requirements/*/Dockerfile | cut -f 2 -d ' ')
for image in "${list[@]}"; do
    docker pull "$image"
done

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

