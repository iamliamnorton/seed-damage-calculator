#!/bin/bash -ex

bundle config --delete without
bundle config --delete frozen

make build

bundle exec rake
