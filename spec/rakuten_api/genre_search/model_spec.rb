# coding: utf-8

require 'spec_helper'

describe RakutenApi::GenreSearch::Model do
  describe ".from_hash" do
    let(:data) {
      {
        'genreId' => '1000',
        'genreName' => 'foo',
        'genreLevel' => '1'
      }
    }
    subject { described_class.from_hash(data) }
    its(:genre_id) { should eql 1000 }
    its(:genre_name) { should eql 'foo' }
    its(:genre_level) { should eql 1 }
  end

  describe "#to_hash" do
    subject {
      described_class.new.tap do |o|
        o.genre_id = 1
        o.genre_name = 'foo'
        o.genre_level = 20
      end.to_hash
    }
    its([:genre_id]) { should eql 1 }
    its([:genre_name]) { should eql 'foo' }
    its([:genre_level]) { should eql 20 }
  end
end