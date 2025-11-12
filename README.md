# ALF Docker containers

This repository hosts the Dockerfiles used to build the ALF container images. The `build.sh` script can be invoked locally or in CI to build every image defined in the tree and push them to the configured registries.

## GitHub Actions pipeline

- The workflow at `.github/workflows/docker-build.yml` builds every image on pushes to `main`, pull requests, or manual triggers.
- Images are published to the GitHub Container Registry namespace `ghcr.io/<owner>/<repository>/...` when the workflow runs on the default branch or via manual dispatch.
- The workflow relies on the built-in `GITHUB_TOKEN` and requests the `packages: write` permission; no additional secrets are required.
- Pull request runs build the images for validation but skip the push step by propagating `PUSH_IMAGES=0` to the build script.

## Local usage

Run `./build.sh` to build all images. To automatically push images, set `REGISTRY_URL` before executing the script.

