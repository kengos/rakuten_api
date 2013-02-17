# coding: utf-8

require 'spec_helper'
require 'json'

describe RakutenApi::ItemSearch::Request do
  describe '#get' do
    let(:response) {
      described_class.new do |params|
        params.add_param :keyword, 'りんご'
        params.add_param :hits, 1
      end.get
    }
    it { response.should be_kind_of ::Faraday::Response }
    it { JSON.parse(response.body)['hits'].should eql 1 }

    it "bad request" do
      described_class.new.get.status.should eql 400
    end
  end
end