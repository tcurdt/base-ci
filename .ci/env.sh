#!/bin/bash

if [ "$CI" != "true" ]; then
  # local deploy
  source .credentials
  return
fi

: "${EMAIL:?EMAIL is mising}"
: "${SSH_PRIVATE_KEY:?SSH_PRIVATE_KEY is mising}"

mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat > ~/.ssh/config <<EOL
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  LogLevel ERROR
EOL

eval "$(ssh-agent -s)" >/dev/null

echo "$SSH_PRIVATE_KEY" | base64 --decode | ssh-add - 2>/dev/null

git config --global user.name "Travis CI"
git config --global user.email "$EMAIL"

# ssh -T git@github.com || exit 0