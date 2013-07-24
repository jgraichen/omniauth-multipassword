module Omniauth
  module Multipassword
    module VERSION
      MAJOR = 0
      MINOR = 4
      PATCH = 1
      STAGE = nil

      def self.to_s
        [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join '.'
      end
    end
  end
end
