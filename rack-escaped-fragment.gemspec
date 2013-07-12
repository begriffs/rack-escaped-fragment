# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/escaped_fragment/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-escaped-fragment"
  spec.version       = Rack::EscapedFragment::VERSION
  spec.authors       = ["Jesse Chan-Norris", "Joe Nelson"]
  spec.email         = ["jcn@indabamusic.com", "cred+github@begriffs.com"]
  spec.description   = %q{Rack middleware to handle the _escaped_fragmet_ parameter that Google uses to crawl sites that do AJAX page loads}
  spec.summary       = %q{Rack middleware to handle Google's #! crawling}
  spec.homepage      = "http://github.com/indabamusic/rack-escaped-fragment"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
end
