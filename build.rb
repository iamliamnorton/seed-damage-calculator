#!/usr/bin/env ruby

# build.rb - ruby bash script by Liam Norton
# my continuous integration and build script

puts "\n* Installing the dependencies specified in the project Gemfile"
system("bundle", "install")

puts "\n* Checking code for design issues with roodi"
system('roodi app/**/*.rb')
# exit 1 if $?.exitstatus > 0

puts "\n* Checking code for over complexity with metric_abc (score over 20 needs refactoring)"
system('metric_abc app/**/*.rb')
# exit 1 if $?.exitstatus > 0

puts "\n* Checking code to detect structural similarities with flay"
system('flay app/**/*.rb')
# exit 1 if $?.exitstatus > 0

puts "\n* Checking code for quality with rails-best-practices"
system('rails_best_practices .')
# exit 1 if $?.exitstatus > 0

puts "\n* Running specs and checking test coverage with simplecov"
# system('rm -rf coverage')
system('rake spec')
# exit 1 if $?.exitstatus > 0
