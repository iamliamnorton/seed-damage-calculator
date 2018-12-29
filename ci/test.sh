#!/bin/bash

set -ex

bundle config --delete without
bundle config --delete frozen

bundle

bundle exec rails db:drop
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rspec
