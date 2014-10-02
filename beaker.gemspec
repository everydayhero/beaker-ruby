# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beaker/version'

Gem::Specification.new do |spec|
  spec.name          = "beaker-ruby"
  spec.version       = Beaker::VERSION
  spec.authors       = ["everydayhero"]
  spec.summary       = %q{Ruby client for Beaker}
  spec.description   = %q{Ruby client for Beaker}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($\)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
