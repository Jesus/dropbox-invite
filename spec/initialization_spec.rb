describe Dropbox::WebClient do
  describe "initialization" do
    it "isn't authenticated at start" do
      client = Dropbox::WebClient::Session.new
      
      expect(client.authenticated?).to be_falsey
    end
    
    it "requires and stores the email" do
      client = Dropbox::WebClient::Session.new(:email => "someone@somewhere.com")
      
      expect(client.email).to eq("someone@somewhere.com")
    end
    
    it "requires and stores the password" do
      client = Dropbox::WebClient::Session.new(:password => "hola")
      
      expect(client.password).to eq("hola")
    end
    
  end
end