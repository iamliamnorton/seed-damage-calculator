.PHONY: test
test:
	./ci/env/test.sh ./ci/test.sh

# db setup...
#
# sudo -u postgres psql postgres
# \password postgres
