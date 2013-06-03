# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fabulist/version'

Gem::Specification.new do |spec|
  spec.name          = "fabulist"
  spec.version       = Fabulist::VERSION
  spec.authors       = ["Robert Schäfer"]
  spec.email         = ["rs@oxon.ch"]
  spec.description   = %q{Keeps track of your created business object. Name your models and tell a nice story about them in your cucumber step definitions.}
  spec.summary       = %q{Reference business objects from anywhere in your cucumber world.}
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
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rb-fsevent"
  spec.add_development_dependency "activerecord-nulldb-adapter"
  spec.add_development_dependency "pry"

end
