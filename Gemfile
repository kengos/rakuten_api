source 'https://rubygems.org'

# Specify your gem's dependencies in rakuten_api.gemspec
gemspec

group :development, :test do
  gem 'rake',           '~> 0.9.2.2', :require => false
  gem 'tapp', git: 'git://github.com/esminc/tapp.git'
  gem 'rspec'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'libnotify', require: false
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'growl', require: false
end