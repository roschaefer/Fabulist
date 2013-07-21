# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fabulist/version'

Gem::Specification.new do |spec|
  spec.name          = "fabulist"
  spec.version       = Fabulist::VERSION
  spec.authors       = ["Robert Schäfer"]
  spec.email         = ["rs@oxon.ch"]
  spec.summary       = %q{Write declarative and vivid cucumber features by referencing shared state across multiple steps.}
  spec.description   = %q{
This gem provides a simple api to memorize arbitrary ruby objects and reference them by:
* their class
* any method that returns true or false
* the order they were memorized
}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "active_support", "~> 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "pry"
end
