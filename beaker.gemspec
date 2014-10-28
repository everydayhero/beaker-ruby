# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beaker/version'

Gem::Specification.new do |spec|
  spec.name          = 'beaker'
  spec.version       = Beaker::VERSION
  spec.authors       = ['everydayhero']
  spec.summary       = 'Ruby client for Beaker'
  spec.description   = 'Ruby client for Beaker'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($ORS)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~>2.1'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.25'
  spec.add_development_dependency 'webmock', '~> 1.20'
end
