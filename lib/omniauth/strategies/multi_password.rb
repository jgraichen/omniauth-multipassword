require "omniauth"
require "omniauth/multipassword/base"

module OmniAuth
  module Strategies
    class MultiPassword
      include OmniAuth::Strategy
      include OmniAuth::MultiPassword::Base

      def initialize(app, *args, &block)
        super(app, *args) do end

        if block.arity == 0
          instance_eval &block
        else
          block.call self
        end
      end

      def options
        yield @options if block_given?
        @options
      end

      def authenticator(klass, *args, &block)
        unless klass.is_a?(Class)
          begin
            klass = OmniAuth::Strategies.const_get("#{OmniAuth::Utils.camelize(klass.to_s)}")
          rescue NameError
            raise LoadError, "Could not find matching strategy for #{klass.inspect}." +
              "You may need to install an additional gem (such as omniauth-#{klass})."
          end
        end

        args << block if block
        @authenticators ||= []
        @authenticators  << [ klass, args ]
      end

      def callback_phase
        username = request[username_id].to_s
        password = request[password_id].to_s
        if authenticate(username, password)
          super
        else
          return fail!(:invalid_credentials)
        end
      end

      def authenticate(username, password)
        @authenticators.each do |auth|
          begin
            @authenticator = auth[0].new @app, *auth[1]
            @authenticator.init_authenticator(@request, @env, username)
            if @authenticator.authenticate(username, password)
              return true
            end
          rescue Error => e
            OmniAuth.logger.warn "OmniAuth ERR >>> " + e
          end
          @authenticator = nil
        end
        false
      end

      def name
        return @authenticator.name if @authenticator
        super
      end

      info do
        info = @authenticator.info if @authenticator
        info = {} unless info.is_a?(Hash)
        info
      end
    end
  end
end
