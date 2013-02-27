source 'https://rubygems.org'

# Specify your gem's dependencies in rakuten_api.gemspec
gemspec

group :development, :test do
  gem "rake", "~> 10.0.3", require: false
  gem 'tapp', git: 'git://github.com/esminc/tapp.git'
  gem 'vcr', git: 'git://github.com/vcr/vcr.git'
end

group :guard do
  gem 'guard'
  gem 'guard-rspec'
  gem 'libnotify', require: false
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'growl', require: false
end