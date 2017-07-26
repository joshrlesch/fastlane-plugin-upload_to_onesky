# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/upload_to_onesky/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-upload_to_onesky'
  spec.version       = Fastlane::UploadToOnesky::VERSION
  spec.author        = %q{joshrlesch}
  spec.email         = %q{josh.r.lesch@gmail.com}

  spec.summary       = %q{Upload a strings file to OneSky}
  spec.homepage      = "https://github.com/joshrlesch/fastlane-plugin-upload_to_onesky"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  
  #spec.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.99.0'
end
