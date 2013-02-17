# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rakuten_api/version'

Gem::Specification.new do |gem|
  gem.name          = "rakuten_api"
  gem.version       = RakutenApi::VERSION
  gem.authors       = ["kengos"]
  gem.email         = ["kengo@kengos.jp"]
  gem.description   = %q{Rakuten Api}
  gem.summary       = %q{Rakuten Api(http://webservice.rakuten.co.jp/)}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'httparty'
  gem.add_development_dependency 'rspec'
end
