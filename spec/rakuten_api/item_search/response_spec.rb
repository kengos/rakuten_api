# coding: utf-8

require 'spec_helper'

describe RakutenApi::ItemSearch::Response do
  let(:client) {
    RakutenApi::ItemSearch::Client.new do |params|
      params.add_param :keyword, 'りんご'
      params.add_param :hits, 2
    end
  }
  let(:response) {
    VCR.use_cassette('item_search_response') do
      client.get
    end
  }

  describe '#initialize' do
    let(:obj) { described_class.new(response) }
    it { obj.page_count.should >= 2 }
    it { obj.page.should eql 1 }
    it { obj.carrier.should eql 0 }
    it { obj.first.should eql 1 }
    it { obj.last.should eql 2 }
    it { obj.should be_success }
    it { obj.should_not be_error }

    context "error raise" do
      it { lambda { described_class.new('foo') }.should raise_error(RakutenApi::Error) }
    end
  end

  describe '#simple_mapping' do
    let(:obj) { described_class.new(response) }
    subject { obj.simple_mapping }
    it { should have(2).items }
    its([0]) { should be_kind_of RakutenApi::ItemSearch::Model }
    its([1]) { should be_kind_of RakutenApi::ItemSearch::Model }
  end

  describe '#next?, #prev?' do
    specify do
      obj = described_class.new(response, client.params)
      obj.should be_next
      obj.should_not be_prev
    end
  end

  describe '#next_page' do
    let(:obj) { described_class.new(response, client.params) }
    let(:next_page) {
      VCR.use_cassette('item_search_response_next_page') do
        obj.get_next_page
      end
    }
    it { next_page.should be_kind_of ::RakutenApi::ItemSearch::Response }
    it { next_page.page.should eql 2 }
    it { next_page.first.should eql 3 }
    it { next_page.last.should eql 4 }

    describe '#prev_page' do
      let(:prev_page) {
        VCR.use_cassette('item_search_response_prev_page') do
          next_page.get_prev_page
        end
      }
      it { prev_page.should be_kind_of ::RakutenApi::ItemSearch::Response }
      it { prev_page.page.should eql 1 }
      it { prev_page.first.should eql 1 }
      it { prev_page.last.should eql 2 }
    end
  end
end