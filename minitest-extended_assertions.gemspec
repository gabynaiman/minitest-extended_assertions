# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/minitest/extended_assertions/version'

Gem::Specification.new do |spec|
  spec.name          = 'minitest-extended_assertions'
  spec.version       = Minitest::ExtendedAssertions::VERSION
  spec.authors       = ['Gabriel Naiman']
  spec.email         = ['gabynaiman@gmail.com']
  spec.summary       = 'Extended assertions for Minitest'
  spec.description   = 'Extended assertions for Minitest'
  spec.homepage      = 'https://github.com/gabynaiman/minitest-extended_assertions'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'minitest', '~> 5.0'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest-colorin', '~> 0.1'
  spec.add_development_dependency 'minitest-line', '~> 0.6'
  spec.add_development_dependency 'simplecov', '~> 0.12'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'pry-nav', '~> 1.0'
end