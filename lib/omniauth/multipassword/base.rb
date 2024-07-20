# frozen_string_literal: true

module OmniAuth
  module MultiPassword
    module Base
      def self.included(base)
        base.class_eval do
          option :title,  'Restricted Access'
          option :fields, %i[username password]

          uid { username }
        end
      end

      def username_id
        options[:fields][0] || 'username'
      end

      def password_id
        options[:fields][1] || 'password'
      end

      def username
        @username || request[username_id].to_s
      end

      def init_authenticator(request, env, username)
        @request  = request
        @env      = env
        @username = username
      end

      def callback_phase
        if authenticate(username, request[password_id])
          super
        else
          fail!(:invalid_credentials)
        end
      end

      def request_phase
        OmniAuth::Form.build(title: options.title, url: callback_url) do |f|
          f.text_field     'Username', username_id
          f.password_field 'Password', password_id
        end.to_response
      end

      def other_phase
        # OmniAuth, by default, disables "GET" requests for security reasons.
        # This effectively disables showing a password form on a GET request to
        # the `request_phase`. Instead, we hook the GET requests here.
        request_phase if on_request_path?
      end
    end
  end
end
