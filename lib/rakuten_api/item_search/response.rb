# coding: utf-8

require 'json'

module RakutenApi
  module ItemSearch
    class Response < ::RakutenApi::Response
      attr_reader :hits
      attr_reader :count
      attr_reader :first
      attr_reader :last
      attr_reader :carrier
      attr_reader :page_count
      attr_reader :page

      def initialize(faraday_response = nil, params = nil)
        super(faraday_response)
        parse_body(@body)
        @request_params = params
      end

      def next?
        @page < @page_count
      end

      def prev?
        @page > 1
      end

      def get_next_page
        nil unless next?
        @request_params[:page] = @page + 1
        new_request
      end

      def get_prev_page
        nil unless prev?
        @request_params[:page] = @page - 1
        new_request
      end

      def new_request
        ::RakutenApi::ItemSearch::Client.new do |params|
          @request_params.each_pair do |k, v|
            params.add_param k, v
          end
        end.request
      end

      def parse_body(data)
        @count = data['count']
        @page = data['page']
        @first = data['first']
        @last = data['last']
        @hits = data['hits']
        @carrier = data['carrier']
        @page_count = data['pageCount']
      end

      def simple_mapping
        [] unless @body.include? "Items"
        [].tap do |result|
          @body["Items"].each do |f|
            next unless f.include? 'Item'
            result << RakutenApi::ItemSearch::Model.from_hash(f['Item'])
          end
        end
      end
    end
  end
end