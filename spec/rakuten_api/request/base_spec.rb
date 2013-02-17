# coding: utf-8

require 'spec_helper'

describe RakutenApi::Request::Base do
  describe '#normalize' do
    shared_examples "should normalize" do |value, expect|
      it { described_class.new.normalize(value).should eql expect }
    end
    context "String" do
      it_behaves_like "should normalize", 'foo', 'foo'
      it_behaves_like "should normalize", 'foo_bar', 'fooBar'
      it_behaves_like "should normalize", 'foo_bar_baz', 'fooBarBaz'
    end

    context "Symbol" do
      it_behaves_like "should normalize", :foo, 'foo'
      it_behaves_like "should normalize", :foo_bar, 'fooBar'
      it_behaves_like "should normalize", :foo_bar_baz, 'fooBarBaz'
    end
  end

  describe '#add_param' do
    let(:obj) { described_class.new }
    context "valid param" do
      before {
        obj.add_param(:application_id, 'foo')
      }
      it { obj[:application_id].should eql 'foo' }
      it { obj['applicationId'].should eql 'foo' }
      it { obj.to_hash.should be_include 'applicationId' }
      it { obj.to_hash.should_not be_include 'application_id' }
    end

    context "invalid param" do
      before {
        obj.add_param(:app_id, 'foo')
      }
      it { obj[:app_id].should be_nil }
      it { p obj }
    end
  end
end