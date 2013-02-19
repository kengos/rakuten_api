# coding: utf-8

require 'spec_helper'

describe RakutenApi::GenreSearch::Client do
  let(:client) {
    described_class.new do |params|
      params.add_param :genre_id, 0
    end
  }

  describe '#request' do
    let(:response) {
      VCR.use_cassette('genre_search_response') do
        client.request
      end
    }
    it { response.should be_kind_of RakutenApi::GenreSearch::Response }
    context :current do
      subject { response.current }
      it { should be_kind_of RakutenApi::GenreSearch::Model }
      its(:genre_id) { should eql 0 }
      its(:genre_name) { should eql '' }
      its(:genre_level) { should eql 0 }
    end
  end

  describe '.root_categories' do
    let(:response) {
      VCR.use_cassette('genre_search_response') do
        described_class.root_categories
      end
    }
    it { response.should be_kind_of Array }
    it { response.first.should be_kind_of RakutenApi::GenreSearch::Model }
  end
end