# coding: utf-8

require 'spec_helper'
require 'json'

describe RakutenApi::ItemRanking::Client do
  let(:client) {
    described_class.new
  }
  describe '#get' do
    let(:response) {
      VCR.use_cassette('item_ranking_response') do
        client.get
      end
    }
    it { response.should be_kind_of ::Faraday::Response }
    it { JSON.parse(response.body)['title'].should eql "【楽天市場】ランキング市場 【総合】" }
  end
end