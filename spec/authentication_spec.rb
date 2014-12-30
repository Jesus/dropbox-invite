describe Dropbox::WebClient do
  describe "authentication" do
    
    it "starts a web session on Dropbox website",
      :cassette => "login" do
      session = Dropbox::WebClient::Session.new(
        :email => "c2553105@trbvm.com",
        :password => "c2551055@trbvm.comc2551055@trbvm.com"
      )
      session.authenticate
      
      
      expect(session.cookies.login_token).to eq("r-gLoiDMnJ98MBj-xzTCJ-gL")
    end
 
  end
end