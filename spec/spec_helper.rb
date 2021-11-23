# frozen_string_literal: true

require 'rspec'
require 'simplecov'

if ENV['CI']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

SimpleCov.start do
  add_filter 'spec'
end

require 'omniauth-multipassword'

Dir[File.expand_path('spec/support/**/*.rb')].sort.each {|f| require f }

RSpec.configure do |config|
  config.order = 'random'

  config.before do
    OmniAuth.config.logger = Logger.new(IO::NULL)
  end
end
