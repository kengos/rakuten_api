# coding: utf-8

require 'spec_helper'

describe RakutenApi::ItemSearch::Response do
  describe '#initialize' do
    let(:response) {
      RakutenApi::ItemSearch::Client.new do |params|
        params.add_param :keyword, 'りんご'
        params.add_param :hits, 2
      end.get
    }
    let(:obj) { described_class.new(response) }

    it { obj.page.should eql 1 }
    it { obj.page_count.should >= 2 } # ...
    it { obj.carrier.should eql 1 }
    it { obj.first.should eql 1 }
    it { obj.last.should eql 2 }
    context "error raise" do
      it { lambda { described_class.new('foo') }.should raise_error(RakutenApi::Error) }
    end
  end
end