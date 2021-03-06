#!/bin/bash
# © 2019 Konopnickiej.Com - Paweł 'felixd' Wojciechowski

REPO="elmarit/harbour"
TAG_DEFAULT_BUILD_ENV="build_ubuntu_latest"

BUILD_ENVS=()

for DIR in *; do
 if [ -d "${DIR}" ]; then
  case "$DIR" in
   build_*    ) BUILD_ENVS+=($DIR) ;;
  esac
 fi
done

echo "+-------------------------------------------------------------------+"
docker version
echo "+-------------------------------------------------------------------+"
echo " *** Building Base Build systems for Harbour Project *** "
echo "+-------------------------------------------------------------------+"
echo " *** Build Environments: ${BUILD_ENVS[@]}"
echo "+-------------------------------------------------------------------+"

# BUILD ENVIRONMENTS
for TAG in ${BUILD_ENVS[@]}; do
 echo "+-------------------------------------------------------------------+"
 echo " *** Building TAG: :$TAG *** "
 echo "+-------------------------------------------------------------------+"
 docker pull $REPO:$TAG || true # In case image does not exist
 docker build --cache-from $REPO:$TAG --pull -t $REPO:$TAG $TAG/
done

docker tag $REPO:$TAG_DEFAULT_BUILD_ENV $REPO:build
docker tag $REPO:$TAG_DEFAULT_BUILD_ENV $REPO:build_base
