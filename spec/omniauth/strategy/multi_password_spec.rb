require 'spec_helper'
require 'rack/test'

describe OmniAuth::Strategies::MultiPassword do
  include Rack::Test::Methods

  class OmniAuth::Strategies::OneTest
    include OmniAuth::Strategy
    include OmniAuth::MultiPassword::Base

    def authenticate(username, password)
      username == 'john' && password == 'secret'
    end
  end

  class OmniAuth::Strategies::TwoTest
    include OmniAuth::Strategy
    include OmniAuth::MultiPassword::Base

    def authenticate(username, password)
      username == 'jane' && password == '1234'
    end
  end

  let(:app) do
    Rack::Builder.new {
      use OmniAuth::Test::PhonySession
      use OmniAuth::Strategies::MultiPassword do
        authenticator :one_test
        authenticator :two_test
      end
      run ->(env) { [404, {'Content-Type' => 'text/plain'}, [env['omniauth.auth']['uid'].to_s]] }
    }.to_app
  end

  it 'shows login FORM' do
    get '/auth/multipassword'

    expect(last_response.body).to include '<form'
  end

  it 'redirect on all failed strategies' do
    post '/auth/multipassword/callback', username: 'paul', password: 'wrong'
    expect(last_response).to be_redirect
    expect(last_response.headers['Location']).to eq '/auth/failure?message=invalid_credentials&strategy=multipassword'
  end

  it 'authenticates john' do
    post '/auth/multipassword/callback', username: 'john', password: 'secret'
    expect(last_response.body).to eq 'john'
  end

  it 'authenticates jane' do
    post '/auth/multipassword/callback', username: 'jane', password: '1234'
    expect(last_response.body).to eq 'jane'
  end
end
