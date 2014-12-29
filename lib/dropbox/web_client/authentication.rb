module Dropbox
  module WebClient
  
    module Authentication

      def authenticated?
        @authenticated
      end

      def authenticate
        get_login
        post_login

        @authenticated = true
      end
      
      # TODO: Should keep in consideration the session expiration...
      def ensure_authenticated
        authenticate unless authenticated?
        true
      end

    private

      # Gets the login URL and keeps the cookies, required to continue the
      # authentication process
      def get_login
        response = RestClient.get(login_url)
        cookies.take response.cookies
        response
      end

      # Posts user credentials and keeps the returned cookies, this'll start a 
      # user session.
      def post_login
        response = RestClient.post(post_login_url, {
          "t" => cookies.login_token,
          "login_email" => @email,
          "login_password" => @password
        }, {:cookies => cookies.all}) do |response, request, result, &block|
          if response.code == 200
            cookies.take response.cookies
            parsed_response = ResponseParser.new(response.body)
            @subject_uid = parsed_response.response_data["id"]
          else
            response.return!(request, result, &block)
          end
        end
        response
      end

      # This step might not be required, it's just following the redirect which
      # we got in the previous authentication step.
      def get_after_login_url
        response = RestClient.get(after_login_url, :cookies => current_cookies)
  
        # Get _subject_uid (hidden field in response HTML)
        parsed_response = ResponseParser.new(response.body, :html, :html)
        @subject_uid = parsed_response.response_data[:subject_uid]
  
        return response
      end

      def subject_uid
        @subject_uid
      end

    end
    
  end
end