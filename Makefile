PROJECT = seed-damage-calculator

.PHONY: build
build: Dockerfile
	docker-compose build

.PHONY: db
db:
	docker-compose run web rake db:create db:migrate db:seed

.PHONY: run
run:
	docker-compose up

.PHONY: shell
shell:
	docker-compose run web bash

.PHONY: stop
stop:
	docker-compose stop && \
	  docker-compose down && \
	  rm -rf tmp/pids/*

.PHONY: test
test:
	docker-compose run web ./ci/env/test.sh ./ci/test.sh

.PHONY: deploy
deploy:
	git push heroku master
