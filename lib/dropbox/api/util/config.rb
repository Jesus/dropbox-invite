module Dropbox
  module API

    module Config
      class << self
        def web_session=(session)
          @web_session = session
        end

        def web_session
          if @web_session.nil?
            raise Dropbox::API::Error::Config.new("Web session hasn't been configured")
          else
            @web_session
          end
        end
      end
    end

  end
end
