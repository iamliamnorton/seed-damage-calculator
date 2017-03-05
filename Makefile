PROJECT = seed-damage-calculator

.PHONY: build
build:
	bundle && \
	  bundle exec rake db:drop && \
	  bundle exec rake db:create && \
	  bundle exec rake db:migrate && \
	  bundle exec rake db:seed

.PHONY: run
run:
	bundle exec rails server

.PHONY: test
test:
	./ci/env/test.sh ./ci/test.sh

.PHONY: deploy
deploy:
	# Latest passing master branch already deployed
