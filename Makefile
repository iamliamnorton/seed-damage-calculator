PROJECT = seed-damage-calculator

.PHONY: build
build:
	bundle && \
	  rake db:create && \
	  rake db:migrate && \
	  rake db:seed

.PHONY: run
run:
	rails server

.PHONY: test
test:
	./ci/env/test.sh ./ci/test.sh
