#!/bin/bash

SHA=`git rev-parse HEAD` || exit 1
TAG=`git describe --exact-match $SHA` || exit 2

echo $TAG

#if [ "$TRAVIS_BRANCH" == "master" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then

  BASE=$(dirname $0)

  $BASE/deploy-github -u tcurdt public
  $BASE/deploy-github-pages public
  $BASE/deploy-s3 public

  $BASE/deploy-github-releases -v v1.0.0 dist/*.tgz
  $BASE/deploy-homebrew dist/*.tgz
  $BASE/deploy-linuxbrew dist/*.tgz

  echo "deployed"
#fi