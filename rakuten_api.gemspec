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
  gem.homepage      = "https://github.com/kengos/rakuten_api"
  gem.license = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency 'faraday', '~> 0.8.5'
  gem.add_development_dependency 'rspec', '~> 2.12'
  gem.add_development_dependency 'vcr', '~> 2.4.0'
  gem.add_development_dependency 'webmock', '~> 1.9.2'
end
