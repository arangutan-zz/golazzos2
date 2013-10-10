# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "public_activity"
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Piotrek Oko\u{144}ski", "Kuba Oko\u{144}ski"]
  s.date = "2013-03-06"
  s.description = "Easy activity tracking for your ActiveRecord models. Provides Activity model with details about actions performed by your users, like adding comments, responding etc."
  s.email = "piotrek@okonski.org"
  s.homepage = "https://github.com/pokonski/public_activity"
  s.post_install_message = "##################################################\n#  NOTE FOR UPGRADING FROM PRE-0.4.0 VERSION     #\n##################################################\n\npublic_activity 0.4.0 brings major changes compared to 0.3.X versions,\nplease read https://github.com/pokonski/public_activity#upgrading \nto learn about all the changes you need to apply to properly\nupgrade your applications.\n"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.0.0"
  s.summary = "Easy activity tracking for ActiveRecord models"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_runtime_dependency(%q<actionpack>, ["~> 3.0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0.5.0"])
      s.add_runtime_dependency(%q<railties>, ["~> 3.0"])
    else
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<actionpack>, ["~> 3.0"])
      s.add_dependency(%q<i18n>, [">= 0.5.0"])
      s.add_dependency(%q<railties>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<actionpack>, ["~> 3.0"])
    s.add_dependency(%q<i18n>, [">= 0.5.0"])
    s.add_dependency(%q<railties>, ["~> 3.0"])
  end
end
