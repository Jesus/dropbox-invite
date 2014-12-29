# -*- encoding: utf-8 -*-
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

  s.add_dependency 'rest-client'
  s.add_dependency 'nokogiri'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'debugger'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end