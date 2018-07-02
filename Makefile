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

.PHONY: deploy
deploy: all
	@./.ci/deploy.sh
