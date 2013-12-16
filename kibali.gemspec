# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kibali/version'

Gem::Specification.new do |spec|
  spec.name          = "kibali"
  spec.version       = Kibali::VERSION
  spec.authors       = ["daudi amani"]
  spec.email         = ["dsaronin@gmail.com"]
  spec.description   = %q{simple Rails role authentication}
  spec.summary       = %q{simple Rails role authentication}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #  spec.add_dependency 'rails', '~> 4.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "shoulda"
  spec.add_development_dependency "turn"


end
