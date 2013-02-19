# coding: utf-8

require 'spec_helper'

describe RakutenApi::GenreSearch::Response do
  let(:client) {
    RakutenApi::GenreSearch::Client.new do |params|
      params.add_param :genre_id, genre_id
    end
  }

  let(:response) {
    VCR.use_cassette('genre_search_response_' + genre_id.to_s) do
      client.get
    end
  }

  context 'root_category' do
    let(:genre_id) { 0 }
    subject { described_class.new(response) }
    its(:status) { should eql 200 }
    its(:body) { should be }
    its(:children) { should be_kind_of Array }
    its('children.first') { should be_kind_of RakutenApi::GenreSearch::Model }
  end

  context 'level 1 category' do
    let(:genre_id) { 551169 }
    let(:obj) { described_class.new(response) }
    it { obj.parents.should eql [] }
    it { obj.children.should be_kind_of Array }
    it { obj.current.genre_level.should eql 1 }
  end

  context "level 2 category" do
    let(:genre_id) { 551172 }
    let(:obj) { described_class.new(response) }
    context '#parents' do
      subject { obj.parents }
      it { should be_kind_of Array }
      context "first" do
        subject { obj.parents.first }
        its(:genre_level) { should eql 1 }
      end
    end
  end
end