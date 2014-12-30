module Dropbox
  module WebClient
    
    module Actions
      def invite(path, emails, message = "", is_shared_folder = nil)
        ensure_authenticated
        
        if is_shared_folder.nil?
          # Determine if the folder exists
          share_options_response = share_options(path)
          
          is_shared_folder = !share_options_response.error?
        end

        params = {
          "emails" => emails.join(","),
          "custom_message" => message,
          "t" => cookies.login_token,
          "_subject_uid" => subject_uid
        }
        if is_shared_folder
          url = invite_more_url
          params["ns_id"] = share_options(path).response_data[:ns_id]
        else
          url = invite_url
          params["path"] = path
        end

        response = RestClient.post(url, params, {:cookies => cookies.all})
        response_text = response.body

        return ResponseParser.new(response_text)
      end

      def share_options(path)
        ensure_authenticated
        url = share_options_url(:path => path)

        response = RestClient.post(url, {
          "t" => cookies.login_token,
          "_subject_uid" => subject_uid
        }, {:cookies => cookies.for_share_options})

        return ResponseParser.new(response.body, :share_options)
      end
    end

  end
end