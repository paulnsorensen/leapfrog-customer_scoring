# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'leapfrog/customer_scoring/version'

Gem::Specification.new do |spec|
  spec.name          = "leapfrog-customer_scoring"
  spec.version       = Leapfrog::CustomerScoring::VERSION
  spec.authors       = ["Paul Sorensen"]
  spec.email         = ["paulnsorensen@gmail.com"]
  spec.description   = %q{Ruby API client for Leapfrog Online customer scoring}
  spec.summary       = %q{Ruby API client for Leapfrog Online customer scoring}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock", "~> 1.14.0"
  spec.add_runtime_dependency "rest-client", "~> 1.6.7"
  spec.add_runtime_dependency "json", "~> 1.8.0"
end
