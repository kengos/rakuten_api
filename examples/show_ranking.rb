# coding: utf-8

# You need
# gem install rakuten_api
# gem install faraday

require 'rakuten_api'
require 'faraday'

RakutenApi.configure do |config|
  config.application_id = "[Your application_id]"
end

client = RakutenApi::ItemRanking::Client.new
response = client.request

response.simple_mapping.each do |f|
  # you need another parameters, see: https://webservice.rakuten.co.jp/api/ichibaitemranking/
  puts f.rank.to_s + ' ' + f.item_name + "\n"
end