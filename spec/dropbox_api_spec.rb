describe Dropbox::API do

  let(:dropbox_api_dir) do
    Dropbox::API::Dir.new({
      :bytes => 0,
      :icon => "folder",
      :is_dir => true,
      :modified => "Thu, 08 May 2014 11:39:52 +0000",
      :path => "/folder c",
      :rev => "324061bdd",
      :revision => 3,
      :root => "dropbox",
      :size => "0 bytes",
      :thumb_exists => false
    })
  end
  
  let(:session) do
    Dropbox::WebClient::Session.new(
      :email => "c2553105@trbvm.com",
      :password => "c2551055@trbvm.comc2551055@trbvm.com"
    )
  end
  
  before(:each) do
    Dropbox::API::Config.web_session = session
  end

  # We're not testing the implementation of
  # {Dropbox::WebClient::Actions.invite} here, we just want to make sure that
  # the proper call is made from the {Dropbox::API::Dir} object.
  it "can be shared" do
    who = "somebody@somewhere.com"
    expect(session).
      to receive(:invite).with(dropbox_api_dir[:path], [who], anything, anything)

    dropbox_api_dir.invite(who)
  end

  it "sharing with more than one email works" do
    who = ["person_1@somewhere.com", "person_2@somewhere.com"]
    expect(session).
      to receive(:invite).with(dropbox_api_dir[:path], who, anything, anything)

    dropbox_api_dir.invite(who)
  end

  it "sharing with someone adds on to list of directory members",
    :cassette => "members_through_api" do
      who = "somebody@somewhere.com"

    expect(dropbox_api_dir.members).not_to include(who)

    dropbox_api_dir.invite(who)

    expect(dropbox_api_dir.members).to include(who)
  end

end if defined? Dropbox::API