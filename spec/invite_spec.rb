describe Dropbox::WebClient::Actions do
  describe "invite" do    
    let(:session) do
      Dropbox::WebClient::Session.new(
        :email => "c2553105@trbvm.com",
        :password => "c2551055@trbvm.comc2551055@trbvm.com"
      )
    end

    # We've recorded VCR cassettes for the following situations on a Dropbox
    # account.
    it "fails if no folder found", :cassette => "invite_unexisting_folder" do
      r = session.invite("/peanuts", ["test1@somewhere.com"])
      
      expect(r.error?).to be_truthy
    end
    
    it "works on already shared folders", :cassette => "invite_shared_folder" do
      r = session.invite("/shared folder", ["test1@somewhere.com"])
      
      expect(r.error?).to be_falsey
      # TODO:
      # Should check folder members to check if the given email is included
    end
 
    it "works on normal folders", :cassette => "invite_existing_folder" do
      r = session.invite("/new folder", ["test1@somewhere.com"])
      
      expect(r.error?).to be_falsey
      # TODO:
      # Should check folder members to check if the given email is included
    end
 
  end
end