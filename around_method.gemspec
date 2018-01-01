# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'around_method/version'

Gem::Specification.new do |spec|
  spec.name          = 'around_method'
  spec.version       = AroundMethod::VERSION
  spec.authors       = ['Gregory Scott']
  spec.email         = ['gregory.c.scott@gmail.com']
  spec.summary       = 'Ruby gem for method composition'
  spec.homepage      = 'https://github.com/scottish613/around_method'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
