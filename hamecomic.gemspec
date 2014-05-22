# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hamecomic/version'

Gem::Specification.new do |spec|
  spec.name          = "hamecomic"
  spec.version       = Hamecomic::VERSION
  spec.authors       = ["i"]
  spec.email         = ["worenote@gmail.com"]
  spec.summary       = %q{Hamecomic.}
  spec.description   = %q{A kind of joke application.}
  spec.homepage      = "https://github.com/pbl-cloud/hamecomic"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.0"
  spec.add_dependency "ruby-opencv", "~> 0.0"
  spec.add_dependency "slop", "~> 3.5"
  spec.executables   = ['hamecomic']
end
