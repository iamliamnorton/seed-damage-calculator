#!/usr/bin/env ruby

# build.rb - ruby bash script by Liam Norton
# my continuous integration and build script

puts "* Installing the dependencies specified in the project Gemfile"
system("bundle", "install")

puts "* Checking code for design issues with roodi"
system('roodi "app/**/*.rb"')
exit 1 if $?.exitstatus > 0

# need to get this working with ruby 1.9.2
# puts "* Checking code to detect complexity with flog"
# system('flog ./app')
# exit 1 if $?.exitstatus > 0

puts "* Checking code to detect structural similarities with flay"
system('flay ./app')
exit 1 if $?.exitstatus > 0

puts "* Checking code for quality with rails-best-practices"
system('rails_best_practices .')
# exit 1 if $?.exitstatus > 0

puts "* Running specs and checking test coverage with simplecov"
# system('rm -rf coverage')
system('rake spec')
exit 1 if $?.exitstatus > 0
