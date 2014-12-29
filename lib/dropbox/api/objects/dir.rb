class Dropbox::API::Dir
  
  # Returns an array of people who have been invited to this shared folder
  def members
    if is_shared_folder?
      client.web_client.share_options(self[:path]).response_data[:members]
    else
      []
    end
  end
  
  def is_shared_folder?
    self.icon == "folder_user"
  end
  
  # Sends an invitation to email
  def invite(emails, message = "")
    emails = [emails] if emails.is_a? String
    
    client.web_client.invite(self[:path], emails, message, is_shared_folder?)
  end

end
