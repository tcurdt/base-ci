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
	@./.ci/deploy-github       public hazelfin/deploy-test
	@./.ci/deploy-github-pages public hazelfin/deploy-test
	@./.ci/deploy-gitlab       public tcurdt/deploy-test
	@./.ci/deploy-bitbucket    public tcurdt/deploy-test
