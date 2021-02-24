#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--image) IMAGE="$2"; shift ;;
        -t|--tag) TAG=$2 ; shift ;;
        -r|--registry) REGISTRY=$2 ; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [[ -z "$TAG" ]]; then
  TAG=$(date +%Y%m%d)
  echo "📝 No tag provided, using: ${TAG}"
fi

if [[ -z "$REGISTRY" ]]; then
  REGISTRY=quay.io/cellgeni/jupyter
  echo "📝 Using default registry ${REGISTRY}"
fi

echo "🐳 Building ${IMAGE} image"
docker build --build-arg tag_name="${TAG}" --tag "${REGISTRY}:${IMAGE}-${TAG}" --file "./${IMAGE}/Dockerfile" "./${IMAGE}"
