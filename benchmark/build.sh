#!/bin/bash
set -x
VER="${VER:-latest}"
TARGET_PLATFORM="${TARGET_PLATFORM:-linux/amd64}"
# grpc
docker build -t gilcamargo/grpc-blog:${VER} --platform ${TARGET_PLATFORM} -f app/grpc.Dockerfile app
docker push gilcamargo/grpc-blog:${VER}
# rest
docker build -t gilcamargo/rest-blog:${VER} --platform ${TARGET_PLATFORM} -f app/rest.Dockerfile app
docker push gilcamargo/rest-blog:${VER}
