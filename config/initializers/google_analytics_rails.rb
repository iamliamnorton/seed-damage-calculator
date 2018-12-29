require 'google-analytics-rails'

GA.tracker = "UA-32798272-1" if Rails.env.production?
