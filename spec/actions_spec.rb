describe Dropbox::WebClient::Actions do

  let(:session) do
    Dropbox::WebClient::Session.new(
      :email => "c2553105@trbvm.com",
      :password => "c2551055@trbvm.comc2551055@trbvm.com"
    )
  end

  describe "invite" do

    it "fails if no folder found", :cassette => "invite_unexisting_folder" do
      r = session.invite("/peanuts", ["test1@somewhere.com"])
      
      expect(r.error?).to be_truthy
    end
    
    it "works on already shared folders", :cassette => "invite_shared_folder" do
      r = session.invite("/shared folder", ["test1@somewhere.com"])
      expect(r.error?).to be_falsey

      r = session.share_options("/shared folder")
      expect(r.response_data[:members].map{|m|m[:email]}).
        to include("test1@somewhere.com")
    end
 
    it "works on normal folders", :cassette => "invite_existing_folder" do
      r = session.invite("/new folder", ["test1@somewhere.com"])
      expect(r.error?).to be_falsey
      
      r = session.share_options("/new folder")
      expect(r.response_data[:members].map{|m|m[:email]}).
        to include("test1@somewhere.com")
    end
 
  end

  describe "share_options" do    

    it "fails if no folder found", :cassette => "share_opts_unexisting" do
      r = session.share_options("/peanuts")

      expect(r.error?).to be_truthy
    end
    
    it "fails if the given folder isn't shared",
      :cassette => "share_opts_existing" do
      r = session.share_options("/unshared folder")
      
      expect(r.error?).to be_truthy
    end
    
    it "works on shared folders", :cassette => "share_opts_shared" do
      r = session.share_options("/shared folder")

      expect(r.response_data[:members].map{|m|m[:email]}).
        to match_array(["c2553105@trbvm.com", "test1@somewhere.com"])
    end

  end

end