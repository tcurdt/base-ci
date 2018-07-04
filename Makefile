include .project

.PHONY: all
all: dist/$(NAME)-$(VERSION).tgz

.PHONY: clean
clean:
	@rm -rf dist
	@rm -rf public

public/index.html:
	@mkdir -p public
	@echo "$(NAME)-$(VERSION) `date`" > public/index.html

dist/$(NAME)-$(VERSION).tgz: public/index.html
	@mkdir -p dist
	@tar czf $@ public

.PHONY: release
release: all
	@git tag -a $(VERSION) -m "releasing $(VERSION)"
	@git push --tags origin master

.PHONY: deploy
deploy: all
	@./.ci/token-deploy-github-releases $(VERSION) dist



# @./.ci/token-deploy-homebrew deploy-test git@github.com:tcurdt/homebrew-tap.git

# @./.ci/ssh-deploy-bitbucket    public tcurdt/deploy-test
# @./.ci/ssh-deploy-github       public hazelfin/deploy-test
# @./.ci/ssh-deploy-github-pages public hazelfin/deploy-test
# @./.ci/ssh-deploy-gitlab       public tcurdt/deploy-test
# @./.ci/ssh-deploy-rsync        public foo@server.com:/dir
# @./.ci/ssh-deploy-sftp         public foo@server.com:/dir

# @./.ci/token-deploy-bitbucket    public tcurdt/deploy-test
# @./.ci/token-deploy-github       public hazelfin/deploy-test
# @./.ci/token-deploy-github-pages public hazelfin/deploy-test
# @./.ci/token-deploy-gitlab       public tcurdt/deploy-test
# @./.ci/token-deploy-s3           public bucket
