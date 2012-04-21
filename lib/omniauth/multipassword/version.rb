module Omniauth
  module Multipassword
    module VERSION
      MAJOR = 0
      MINOR = 2
      PATCH = 0
      STAGE = nil

      def self.to_s
        [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join '.'
      end
    end
  end
end
