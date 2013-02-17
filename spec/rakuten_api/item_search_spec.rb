# coding: utf-8

require "spec_helper"
require 'json'
describe RakutenApi::ItemSearch do
  describe :get do
    it do
      client = RakutenApi::ItemSearch.new(RakutenApi.application_id)
      JSON.parse(client.get do |c|
        c.add_param('keyword', 'りんご')
      end.body).tapp
    end
  end
end