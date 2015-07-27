module Dropbox
  module WebClient

    class Session
      include Paths
      include Authentication
      include Actions

      attr_accessor :email, :password
      attr_reader :cookies

      def initialize(credentials = {})
        # Initialize login details
        @email = credentials[:email]
        @password = credentials[:password]

        # Initialize cookie manager
        @cookies = CookieManager.new

        # Start unauthenticated
        @authenticated = false
      end

    end

  end
end
