#!/bin/bash
set -e

BASE=$(dirname $0)

if [ "$CI" == "true" ]; then
  echo "continous integration"
  #if [ "$TRAVIS_BRANCH" == "master" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  source $BASE/env.sh
else
  echo "local"
  source .credentials
fi

SRC=public

echo "github:"
$BASE/deploy-github       $SRC hazelfin/deploy-test

echo "github pages:"
$BASE/deploy-github-pages $SRC hazelfin/deploy-test

echo "gitlab:"
$BASE/deploy-gitlab       $SRC tcurdt/deploy-test

echo "bitbucket:"
$BASE/deploy-bitbucket    $SRC tcurdt/deploy-test
# $BASE/deploy-rsync        $SRC tcurdt@vafer.org:/home/tcurdt/deploy-test
# $BASE/deploy-s3           $SRC deploy-7d50e3

SRC=dist

# SHA=`git rev-parse HEAD 2>/dev/null` || { echo "no git repo"; exit 1; }
# TAG=`git describe --exact-match $SHA 2>/dev/null` || { echo "not a tag"; exit 2; }

# $BASE/deploy-github-releases -v $TAG $SRC/*.tgz
# $BASE/deploy-homebrew        -v $TAG $SRC/*.tgz
# $BASE/deploy-linuxbrew       -v $TAG $SRC/*.tgz

echo "done"
