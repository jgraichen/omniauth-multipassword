require 'spec_helper'
require 'rack/test'

describe OmniAuth::MultiPassword::Base do
  let(:app) { double 'app' }
  let(:args) { [] }
  let(:block) { nil }

  class OmniAuth::Strategy::OneTest
    include OmniAuth::Strategy
    include OmniAuth::MultiPassword::Base

    def authenticate(username, password)
      username == 'john' && password == 'secret'
    end
  end

  let(:strategy) do
    OmniAuth::Strategy::OneTest.new(app, *args, &block)
  end

  subject { strategy }

  describe '#username_id' do
    subject { strategy.username_id }

    it 'defaults to :username' do
      is_expected.to eq :username
    end

    context 'when configured' do
      let(:args) { [{fields: [:user, :pass]}] }
      it { is_expected.to eq :user }
    end
  end

  describe '#password_id' do
    subject { strategy.password_id }

    it 'defaults to :password' do
      is_expected.to eq :password
    end

    context 'when configured' do
      let(:args) { [{fields: [:user, :pass]}] }
      it { is_expected.to eq :pass }
    end
  end

  describe 'single strategy' do
    include Rack::Test::Methods

    let(:app) do
      Rack::Builder.new {
        use OmniAuth::Test::PhonySession
        use OmniAuth::Strategies::OneTest
        run ->(env) { [404, {'Content-Type' => 'text/plain'}, [env.key?('omniauth.auth').to_s]] }
      }.to_app
    end

    it 'shows login FORM' do
      get '/auth/onetest'

      expect(last_response.body).to include '<form'
    end

    it 'redirect on wrong password' do
      post '/auth/onetest/callback', username: 'john', password: 'wrong'
      expect(last_response).to be_redirect
      expect(last_response.headers['Location']).to eq '/auth/failure?message=invalid_credentials&strategy=onetest'
    end

    it 'authenticates john with correct password' do
      post '/auth/onetest/callback', username: 'john', password: 'secret'
      expect(last_response.body).to eq 'true'
    end
  end
end
