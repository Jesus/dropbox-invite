class Dropbox::API::Dir
  
  # Returns an array of people who have been invited to this shared folder
  def members
    @members ||= if is_shared_folder?
      Dropbox::API::Config.web_session.
        share_options(self[:path]).
        response_data[:members].
        map{|member_info| member_info[:email]}
    else
      []
    end
  end
  
  def is_shared_folder?
    @is_shared_folder ||= self.icon == "folder_user" # Not very reliable...
  end
  
  def is_shared_folder=(value)
    @is_shared_folder = value
  end
  
  # Sends an invitation to email
  def invite(emails, message = "")    
    emails = [emails] if emails.is_a? String
    
    response = Dropbox::API::Config.web_session.invite(self[:path], emails, message, is_shared_folder?)
    
    # This is now a shared folder
    @is_shared_folder = true

    # Clear out cache of members so it'll be fetched again when asked
    @members = nil
    
    response
  end

end
