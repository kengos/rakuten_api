# coding: utf-8

require 'spec_helper'

describe RakutenApi::ItemRanking::Model do
  describe '.from_hash' do
    context "ItemRankingData" do
      let(:hash_data) {
        {
          "rank" => 10,
          "carrier" => 1,
        }
      }
      subject { described_class.from_hash(hash_data) }
      its(:rank) { should eql 10 }
      its(:carrier) { should eql 1 }
    end
  end
end