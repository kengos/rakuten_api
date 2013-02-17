# coding: utf-8

require "spec_helper"
require 'json'
describe RakutenApi::ItemSearch do
  describe :get do
    it do
      client = RakutenApi::ItemSearch.new(RakutenApi.app_id)
      JSON.parse(client.get do |c|
        c.add_params('keyword', 'りんご')
      end.body).tapp
    end
  end
end