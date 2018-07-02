#!/bin/sh

: "${EMAIL:?EMAIL is mising}"
: "${SSH_PRIVATE_KEY:?SSH_PRIVATE_KEY is mising}"

git config --global user.name "Travis CI"
git config --global user.email "$EMAIL"

mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

eval "$(ssh-agent -s)"

echo "$SSH_PRIVATE_KEY" | base64 --decode > foo
chmod 600 foo
echo "keygen"
ssh-keygen -y -f foo
echo "add"
ssh-add foo

# echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
# echo "$SSH_PRIVATE_KEY" | base64 --decode | ssh-add - > /dev/null
# echo "$SSH_PRIVATE_KEY" | base64 --decode > .ssh/travis
# chmod 600 .ssh/travis
# ssh-add .ssh/travis

echo "checking key"
ssh -T git@github.com
# ssh -i .ssh/travis -T git@github.com
