#!/bin/bash

if [ "$CI" != "true" ]; then
  # local deploy
  source .credentials
  return
fi

: "${EMAIL:?EMAIL is mising}"
: "${SSH_PRIVATE_KEY:?SSH_PRIVATE_KEY is mising}"

if [ -f ~/.ssh/config ]; then
  # ran before
  echo "env setup already"
  return
fi
echo "env setup"

mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat > ~/.ssh/config <<EOL
Host *
  StrictHostKeyChecking no
EOL

eval "$(ssh-agent -s)"

echo "$SSH_PRIVATE_KEY" | base64 --decode | ssh-add -

git config --global user.name "Travis CI"
git config --global user.email "$EMAIL"

# ssh -T git@github.com || exit 0
