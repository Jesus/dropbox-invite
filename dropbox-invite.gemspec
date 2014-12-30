# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "dropbox/web_client/version"

Gem::Specification.new do |s|
  s.name        = "dropbox-invite"
  s.version     = Dropbox::WebClient::VERSION
  s.authors     = ["Jesus Burgos Macia"]
  s.email       = ["jburmac@gmail.com"]
  s.homepage    = "https://github.com/Jesus/dropbox-invite"
  s.summary     = "Invite people to shared folders in Dropbox"
  s.description = "It's capable of working as an extension for dropbox-api to allow folder invites"
  s.license     = "GPL-3.0"

  s.rubyforge_project = "dropbox-invite"

  s.add_dependency 'rest-client', "~> 1.6"
  s.add_dependency 'nokogiri', "~> 1.6"

  s.add_development_dependency 'dropbox-api', "~> 0.4"

  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake"

  s.add_development_dependency 'rspec', "~> 3.1"
  s.add_development_dependency 'vcr', "~> 2.9"
  s.add_development_dependency 'webmock', "~> 1.17"
  s.add_development_dependency 'debugger', "~> 1.6"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
end