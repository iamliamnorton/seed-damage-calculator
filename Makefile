.PHONY: test
test:
	./ci/env/test.sh ./ci/test.sh

.PHONY: db
db:
	rake db:create && \
	  rake db:migrate && \
	  rake db:seed
