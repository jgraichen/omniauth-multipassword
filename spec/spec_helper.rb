require 'rspec'

if ENV['CI'] || (defined?(:RUBY_ENGINE) && RUBY_ENGINE != 'rbx')
  begin
    require 'simplecov'
    SimpleCov.start
  rescue LoadError
  end
end

require 'omniauth-multipassword'

Dir[File.expand_path('spec/support/**/*.rb')].each {|f| require f }

# Disable omniauth logger
class NullLogger < Logger
  def initialize(*args)
  end

  def add(*args, &block)
  end
end

OmniAuth.config.logger = NullLogger.new

RSpec.configure do |config|
  config.order = 'random'
end
