# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'malygos/version'

Gem::Specification.new do |spec|
  spec.name          = "malygos"
  spec.version       = Malygos::VERSION
  spec.authors       = ["Akkiros"]
  spec.email         = ["kwj96966@gmail.com"]
  spec.summary       = %q{upload rails assets to amazon s3}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "jeweler"

end
