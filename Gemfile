# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'activejob', '~> 6.0'
gem 'aws-sdk-s3', '~> 1.60'
gem 'clamby', '~> 1.6'
gem 'ddtrace', '~> 0.36'
gem 'faraday'
gem 'http'
gem 'nokogiri', '~> 1.10'
gem 'ruby_tika_app', '~> 1.9'
gem 'sidekiq', '~> 6.0'

# Development gems
# Since this isn't a Rails app, there really isn't a functional way to distinguish between dev/test gems and the gems
# used when this is run in production, so we're just going to list them out here:

gem 'guard', '~> 2.16'
gem 'guard-rspec', '~> 4.7'
gem 'niftany'
gem 'pry'
gem 'rspec', '~> 3.9'
gem 'rspec-its', '~> 1.3'
gem 'simplecov', '0.17.1', require: false
gem 'vcr', require: false
gem 'webmock', require: false

# Niftany needs to be update to work with version 0.84 and later
gem 'rubocop', '< 0.84'

gem 'mini_magick', '~> 4.11'

gem 'image_processing', '~> 1.12'
