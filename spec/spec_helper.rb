# coding: utf-8

begin
  require 'tapp'
rescue Exception
end

require 'faraday'
require File.expand_path(File.dirname(__FILE__) + '/../lib/rakuten_api')

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

RakutenApi.configure do |config|
  config.app_id = "16d8dfe13fde99ac5479d789764d2f7a"
end