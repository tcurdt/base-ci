#!/bin/bash

BASE=$(dirname $0)
SHA=`git rev-parse HEAD 2>/dev/null` || { echo "no git repo"; exit 1; }
TAG=`git describe --exact-match $SHA 2>/dev/null` || { echo "not a tag"; exit 2; }

if [ "$CI" == "true" ]; then
  echo "continous integration"
  #if [ "$TRAVIS_BRANCH" == "master" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
else
  echo "local"
  source .credentials
fi

SRC=public

# URI=https://${GITHUB_PERSONAL_ACCESS_TOKEN}@github.com/hazelfin/deploy-test.git
# URI=https://tcurdt:${BITBUCKET_APP_PASSWORD}@bitbucket.org/tcurdt/deploy-test.git
# URI=https://tcurdt:${GITLAB_PERSONAL_ACCESS_TOKEN}@gitlab.com/tcurdt/deploy-test.git

$BASE/deploy-github-pages $SRC tcurdt tcurdt/deploy-test
# $BASE/deploy-github       $SRC tcurdt hazelfin/deploy-test
# $BASE/deploy-gitlab       $SRC tcurdt tcurdt/deploy-test
# $BASE/deploy-bitbucket    $SRC tcurdt tcurdt/deploy-test
# $BASE/deploy-s3           $SRC deploy-7d50e3

SRC=dist

# $BASE/deploy-github-releases -v $TAG $SRC/*.tgz
# $BASE/deploy-homebrew        -v $TAG $SRC/*.tgz
# $BASE/deploy-linuxbrew       -v $TAG $SRC/*.tgz

echo "deployed"
