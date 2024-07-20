# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in omniauth-multipassword.gemspec
gemspec

gem 'appraisal'

gem 'rake'
gem 'rake-release'

group :test do
  gem 'rack-test'

  gem 'rspec', '~> 3.0'

  gem 'codecov', require: false
  gem 'simplecov', require: false
end

group :development do
  gem 'rubocop-config', github: 'jgraichen/rubocop-config', ref: 'v12'
end
