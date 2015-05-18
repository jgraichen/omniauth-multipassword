require 'rspec'

if ENV['CI'] || (defined?(:RUBY_ENGINE) && RUBY_ENGINE != 'rbx')
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'omniauth-multipassword'

Dir[File.expand_path('spec/support/**/*.rb')].each {|f| require f }

RSpec.configure do |config|
  config.order = 'random'
end
