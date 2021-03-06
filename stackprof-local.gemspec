# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stackprof/local/version'

Gem::Specification.new do |spec|
  spec.name          = "stackprof-local"
  spec.version       = Stackprof::Local::VERSION
  spec.authors       = ["Strech (Sergey Fedorov)"]
  spec.email         = ["strech_ftf@mail.ru"]
  spec.summary       = "Read stackprof dumps localy"
  spec.description   = "Allow read stackprof dump from remote machine on your local machine"
  spec.homepage      = "https://github.com/Strech/stackprof-local"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "stackprof", "= 0.2.7"
  spec.add_dependency "stackprof-remote", "~> 0.0.6"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
