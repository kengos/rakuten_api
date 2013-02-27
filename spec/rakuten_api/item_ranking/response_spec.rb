# coding: utf-8

require 'spec_helper'

describe RakutenApi::ItemRanking::Response do
  let(:client) { RakutenApi::ItemRanking::Client.new }
  let(:response) {
    VCR.use_cassette('item_ranking_response') do
      client.get
    end
  }

  describe '#initialize' do
    let(:obj) { described_class.new(response) }
    it { obj.title.should == '【楽天市場】ランキング市場 【総合】' }
    it { obj.last_build_date.should be_kind_of DateTime }
    it { obj.page.should eql 1 }
  end

  describe '#simple_mapping' do
    let(:obj) { described_class.new(response).simple_mapping }
    it { obj.should be_kind_of Array }
    it { obj.first.should be_kind_of ::RakutenApi::ItemRanking::Model }
    # 基本30件だが、出てこない場合がある様子
    # xit {
    #   obj.each_with_index do |o, i|
    #     o.rank.should == i + 1
    #   end
    # }
  end

  describe '#next_ranking' do
    let(:obj) { described_class.new(response, client.params) }
    let(:next_ranking) {
      VCR.use_cassette('item_ranking_response_next_ranking') do
        obj.next_ranking
      end
    }
    it { next_ranking.should be_kind_of ::RakutenApi::ItemRanking::Response }
    it { next_ranking.page.should eql 2 }

    describe '#prev_ranking' do
      let(:prev_ranking) {
        VCR.use_cassette('item_ranking_response_prev_ranking') do
          next_ranking.prev_ranking
        end
      }
      it { prev_ranking.should be_kind_of ::RakutenApi::ItemRanking::Response }
      it { prev_ranking.page.should eql 1 }
    end
  end

  context 'error_response' do
    let(:error_response) {
      client.add_param :page, 0
      VCR.use_cassette('item_ranking_error_response') do
        client.request
      end
    }
    it { error_response.should be_kind_of ::RakutenApi::ItemRanking::Response }
    it { error_response.should be_error }
    it { error_response.error_message.should == 'wrong_parameter: page must be over 1' }
  end

  context 'guard' do
    subject { described_class.new }
    its(:status) { should be_nil }
    its(:body) { should == {} }
    its(:page) { should == 1 }
    its(:title) { should be_nil }
    its(:last_build_date) { should be_nil }
    its(:simple_mapping) { should == [] }
  end
end