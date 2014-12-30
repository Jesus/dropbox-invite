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
    it "fails if no folder found", :cassette => "share_opts_unexisting" do
      r = session.share_options("/peanuts")

      expect(r.error?).to be_truthy
    end
    
    it "works on already shared folders", :cassette => "share_opts_shared" do
      r = session.share_options("/shared folder")

      expect(r.response_data[:members].map{|m|m[:email]})
        to match_array(["c2553105@trbvm.com", "test1@somewhere.com"])
    end
 
  end
end