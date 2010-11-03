# -*- encoding: utf-8 -*-
require File.expand_path("../lib/netzke/persistence/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "netzke-persistence"
  s.version     = Netzke::Persistence::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = []
  s.email       = []
  s.homepage    = "http://rubygems.org/gems/netzke-persistence"
  s.summary     = "Persistence for Netzke components"
  s.description = "One approach to user/role-aware persistence for the Netzke framework"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "netzke-persistence"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
