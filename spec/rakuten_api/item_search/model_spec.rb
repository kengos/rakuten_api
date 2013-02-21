# coding: utf-8

require 'spec_helper'

describe RakutenApi::ItemSearch::Model do
  describe '.from_hash' do
    context "BooleanData" do
      let(:hash_data) {
        {
          "imageFlag" => 1,
          "availability" => 1,
          "taxFlag" => 0,
          "postageFlag" => 1,
          "creditCardFlag" => 1,
          "shopOfTheYearFlag"=> 0,
          "shipOverseasFlag"=> 0,
          "asurakuFlag"=> 0,
          "giftFlag" => 0,
        }
      }
      subject { described_class.from_hash(hash_data) }
      its(:image_flag) { should be_true }
      its(:availability) { should be_true }
      its(:tax_flag) { should be_false }
      its(:postage_flag) { should be_true }
      its(:credit_card_flag) { should be_true }
      its(:shop_of_the_year_flag) { should be_false }
      its(:ship_overseas_flag) { should be_false }
      its(:asuraku_flag) { should be_false }
      its(:gift_flag) { should be_false }
    end
  end
end