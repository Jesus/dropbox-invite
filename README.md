# dropbox-invite

[![Gem Version](https://badge.fury.io/rb/dropbox-invite.svg)](http://badge.fury.io/rb/dropbox-invite)
[![Code Climate](https://codeclimate.com/github/Jesus/dropbox-invite/badges/gpa.svg)](https://codeclimate.com/github/Jesus/dropbox-invite)
## UPDATE

Dropbox has recently changed their authentication process to prevent non-humans
from logging in. Unfortunately for this library we haven't been able to break
this restriction just yet.

Therefore, **this library is useless at the moment**.

## Introduction

This gem allows you to invite other users to a shared folder in Dropbox. It's
known that Dropbox API doesn't allow this operation, however it's a requirement
in some scenarios.

To achieve this functionality and due to the lack of implementation in the
official API, the library relies on
[rest-client](https://github.com/rest-client/rest-client) and
[nokogiri](http://www.nokogiri.org) to perform the action through the web
interface.

### Scope

This gem is meant to provide a missing functionality, not to build another
API implementation. Ideally you'd use this library in combination with
some actual implementation of the Dropbox API.

I recommend [dropbox-api](https://github.com/futuresimple/dropbox-api) just
because I've included integration for it. If `Dropbox::API` is found
the existing classes will be extended to allow you invite people to your
folders. This is shown in the examples below.

### Disclaimer

This gem depends 100% on the parsing of the HTML from Dropbox web pages,
therefore a change in their layouts might result in a broken library. Please,
keep this in mind if you're planning to use this in a production environment.

Another drawback of using the web interface is of course the speed.

## How to use

### Using it with `dropbox-api` (recommended)

First, you'll need to set up `dropbox-api` as explained in the [gem's README]
(https://github.com/futuresimple/dropbox-api):

```ruby
Dropbox::API::Config.app_key    = YOUR_APP_KEY
Dropbox::API::Config.app_secret = YOUR_APP_SECRET
Dropbox::API::Config.mode       = "dropbox" # This is a requirement
```

At this point you're able to instantiate a `Dropbox::API::Client` object either
through web-based authorization or rake-based. So far, nothing new.

Additionally you'll need to set up the web login credentials as part of the
API settings to enable the initialization of a web client when it's required.

```ruby
Dropbox::API::Config.web_session = Dropbox::WebClient::Session.new(
  :email => "example@corkeryfisher.info",
  :password => "yourPassw0rd"
)
```

Note that the web authentication won't happen until you actually need it, i.e.
when the `invite` method is invoked.

Now, assuming that you've got a `Dropbox::API::Dir` object called `some_dir`,
you'd be able to perform this:

```ruby
response = some_dir.invite("kirsten.greenholt@corkeryfisher.info")
# => #<Dropbox::WebClient::ResponseParser ... >
response.error?
# => false
response.response_data
# => {"success_msg"=>"Created shared folder 'folder x'", "sf_info"=>{"mount_point"=>"/folder x", "user_id"=>372486289, "extra_count"=>0, "sort_rank"=>nil, "encoded_sort_key"=>["NkhCMjROBloBDAEMAA=="], "other_emails"=>[], "other_names"=>[], "modified_pretty"=>"just now", "href"=>"/home/folder%20x", "modified_ts"=>1420051083, "filename"=>"folder x", "target_ns_id"=>791334450, "icon"=>"folder_user"}}
```

Additionally you can check who's included in the dir through `members`:

```ruby
some_dir.members
# => ["example@corkeryfisher.info", "kirsten.greenholt@corkeryfisher.info"]
```

### Using it on its own (standalone, not recommended)
```ruby
session = Dropbox::WebClient::Session.new(
  :email => "your@account.com",
  :password => "yourPassw0rd"
)
session.invite("/folder path", ["kirsten.greenholt@corkeryfisher.info"])
# => #<Dropbox::WebClient::ResponseParser ... >
```

## To do

Would be nice to:

- [ ] Record tests in HTTP instead of HTTPS so they'd be readable. To do so
      we'll need a proxy.
- [ ] Implement other functions (share permissions, etc).
- [ ] Improve error handling.
- [ ] Add setting to disable lazy authentication.

## Problems?

Please report them in [issues](https://github.com/Jesus/dropbox-invite/issues)
