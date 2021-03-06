# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'action_version/version'

Gem::Specification.new do |spec|
  spec.name          = "actionversion"
  spec.version       = ActionVersion::VERSION
  spec.authors       = ["Seba Gamboa"]
  spec.email         = ["me@sagmor.com"]
  spec.summary       = %q{Elegant versioning of APIs}
  spec.description   = %q{ActionVersion provides a simple and elegant way of versioning REST APIs}
  spec.homepage      = "https://github.com/sagmor/actionversion"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", '~> 3.0.0'
end
