generate a ssh key

    mkdir -p .ci/ssh && ssh-keygen -t rsa -b 4096 -C "ci@vafer.org" -N '' -f .ci/ssh/ci

add `.ci/ssh/ci.pub` to github/gitlab/bitbucket

    https://github.com/hazelfin/deploy-test/settings/keys

check that you have access

    ssh -i .ci/ssh/ci -T git@github.com

store the private key as encrypted env var

    travis encrypt SSH_PRIVATE_KEY="`cat .ci/ssh/ci | base64`"




    travis encrypt-file .ci/ssh/travis --add
    https://travis-ci.org/<username>/<repository>/settings