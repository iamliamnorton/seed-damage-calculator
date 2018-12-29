#!/bin/bash -ex


export RAILS_ENV="test"

export POSTGRES_USER="postgres"
export POSTGRES_PASS="password"
export POSTGRES_HOST="postgres"
export POSTGRES_PORT="5432"
export DATABASE_NAME="seed_test"

export DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASS}@${POSTGRES_HOST}:${POSTGRES_PORT}/${DATABASE_NAME}"

bundle config --delete without
bundle config --delete frozen

bundle

bundle exec rails db:drop
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rspec
