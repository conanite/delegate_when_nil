# -*- coding: utf-8; mode: ruby  -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'delegate_when_nil/version'

Gem::Specification.new do |gem|
  gem.name          = "delegate_when_nil"
  gem.version       = DelegateWhenNil::VERSION
  gem.authors       = ["Conan Dalton"]
  gem.license       = "MIT"
  gem.email         = ["conan@conandalton.net"]
  gem.description   = %q{Like #delegate, but assumes the target method already exists, and delegates only when the local method returns nil}
  gem.summary       = %q{Like #delegate, but assumes the target method already exists, and delegates only when the local method returns nil}
  gem.homepage      = "https://github.com/conanite/delegate_when_nil"

  gem.add_dependency 'not_blank'
  gem.add_development_dependency 'rspec'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
