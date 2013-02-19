# coding: utf-8

require 'spec_helper'
require 'json'

describe RakutenApi::ItemSearch::Client do
  let(:client) {
    described_class.new do |params|
      params.add_param :keyword, 'りんご'
      params.add_param :hits, 2
    end
  }
  describe '#get' do
    let(:response) {
      VCR.use_cassette('item_search_response') do
        client.get
      end
    }
    it { response.should be_kind_of ::Faraday::Response }
    it { JSON.parse(response.body)['hits'].should eql 2 }

    it "bad request" do
      described_class.new.get.status.should eql 400
    end
  end

  describe '#request' do
    let(:response) {
      VCR.use_cassette('item_search_response') do
        client.request
      end
    }
    it { response.should be_kind_of ::RakutenApi::ItemSearch::Response }
  end
end