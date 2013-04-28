# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fabulist/version'

Gem::Specification.new do |spec|
  spec.name          = "fabulist"
  spec.version       = Fabulist::VERSION
  spec.authors       = ["Robert Schäfer"]
  spec.email         = ["rs@oxon.ch"]
  spec.description   = %q{ Fabulist provides a ubiquitous language to reference and interact with your domain models}
  spec.summary       = %q{ Narrate, don't write cucumber step definitions}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "factory_girl", "1.3.2"
  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rb-fsevent", '~> 0.9'

end
