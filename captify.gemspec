# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "captify"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Huiming Teo"]
  s.date = "2012-07-16"
  s.description = "Capistrano capify with canned templates."
  s.email = "teohuiming@gmail.com"
  s.executables = ["captify"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/captify",
    "captify.gemspec",
    "lib/captify.rb",
    "lib/captify/cli.rb",
    "lib/captify/runner.rb",
    "lib/captify/template.rb",
    "lib/captify/template_bundle.rb",
    "lib/captify/template_loader.rb",
    "lib/captify/template_registrar.rb",
    "spec/captify/cli_spec.rb",
    "spec/captify/runner_spec.rb",
    "spec/captify/template_bundle_spec.rb",
    "spec/captify/template_loader_spec.rb",
    "spec/captify/template_registrar_spec.rb",
    "spec/captify/template_spec.rb",
    "spec/captify_spec.rb",
    "spec/data/files/Gemfile.test_captify",
    "spec/data/files/Gemfile.test_captify.lock",
    "spec/data/files/load_path/not-template/lib/not_template.rb",
    "spec/data/files/load_path/template-without-lib/template_bundle.rb",
    "spec/data/files/load_path/template1/lib/template_bundle.rb",
    "spec/data/files/load_path/template2/lib/template_bundle.rb",
    "spec/data/files/rubygems/gems/not-template-1.0.0/lib/not_template.rb",
    "spec/data/files/rubygems/gems/template1-1.0.0/lib/template_bundle.rb",
    "spec/data/files/rubygems/gems/template1-1.0.0/templates/rails-base/config/deploy.rb",
    "spec/data/files/rubygems/gems/template1-1.0.0/templates/rails-base/config/deploy/production.rb",
    "spec/data/files/rubygems/gems/template1-1.0.0/templates/rails-base/config/deploy/staging.rb",
    "spec/data/files/rubygems/gems/template1-1.0.0/templates/sinatra-base/config/deploy.rb",
    "spec/data/files/rubygems/gems/template2-1.0.0/lib/template_bundle.rb",
    "spec/data/files/rubygems/specifications/not-template-1.0.0.gemspec",
    "spec/data/files/rubygems/specifications/template1-1.0.0.gemspec",
    "spec/data/files/rubygems/specifications/template2-1.0.0.gemspec",
    "spec/helper.rb"
  ]
  s.homepage = "http://github.com/teohm/captify"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Capistrano capify with canned templates."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<minitest>, ["~> 3.2.0"])
      s.add_development_dependency(%q<debugger>, [">= 0"])
      s.add_development_dependency(%q<debugger-pry>, [">= 0"])
    else
      s.add_dependency(%q<capistrano>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<minitest>, ["~> 3.2.0"])
      s.add_dependency(%q<debugger>, [">= 0"])
      s.add_dependency(%q<debugger-pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<minitest>, ["~> 3.2.0"])
    s.add_dependency(%q<debugger>, [">= 0"])
    s.add_dependency(%q<debugger-pry>, [">= 0"])
  end
end

