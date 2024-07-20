# frozen_string_literal: true

module Omniauth
  module Multipassword
    module VERSION
      MAJOR = 2
      MINOR = 0
      PATCH = 0
      STAGE = 'rc1'

      def self.to_s
        [MAJOR, MINOR, PATCH, STAGE].compact.join '.'
      end
    end
  end
end
