module Dropbox
  module WebClient

    # Cookie management, this is what will preserve our session
    class CookieManager
      def initialize
        clear_cookies
      end

      def take(cookies)
        @cookies ||= {}
        @cookies.merge! cookies
      end

      # Returns a hash with all collected cookies.
      def all
        @cookies
      end

      # Returns a hash with cookies relevant for the `share_options` action.
      def for_share_options
        valid_keys = ["bjar", "blid", "forumjar", "forumlid", "gvc", "jar",
                      "l", "lid", "locale", "puc", "t"]
        all.select do |k, v|
          valid_keys.include? k
        end
      end

      def clear_cookies
        @cookies = {}
      end

      def login_token
        @cookies["t"]
      end

    end

  end
end
