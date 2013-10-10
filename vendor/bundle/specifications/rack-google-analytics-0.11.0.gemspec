# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rack-google-analytics"
  s.version = "0.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lee Hambley"]
  s.date = "2012-08-17"
  s.description = "Simple Rack middleware for implementing google analytics tracking in your Ruby-Rack based project. Supports synchronous and asynchronous insertion and configurable load options."
  s.email = ["lee.hambley@gmail.com"]
  s.homepage = "https://github.com/leehambley/rack-google-analytics"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Rack middleware to inject the Google Analytics tracking code into outgoing responses."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.5.1"])
      s.add_development_dependency(%q<shoulda>, ["~> 2.11.3"])
      s.add_development_dependency(%q<rack>, ["~> 1.2.0"])
      s.add_development_dependency(%q<rack-test>, ["~> 0.5.4"])
    else
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<test-unit>, ["~> 2.5.1"])
      s.add_dependency(%q<shoulda>, ["~> 2.11.3"])
      s.add_dependency(%q<rack>, ["~> 1.2.0"])
      s.add_dependency(%q<rack-test>, ["~> 0.5.4"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<test-unit>, ["~> 2.5.1"])
    s.add_dependency(%q<shoulda>, ["~> 2.11.3"])
    s.add_dependency(%q<rack>, ["~> 1.2.0"])
    s.add_dependency(%q<rack-test>, ["~> 0.5.4"])
  end
end
