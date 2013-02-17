# coding: utf-8

require 'json'

module RakutenApi
  module ItemSearch
    class Response
      attr_reader :status
      attr_reader :body
      attr_reader :hits
      attr_reader :count
      attr_reader :first
      attr_reader :last
      attr_reader :carrier
      attr_reader :page_count
      attr_reader :page

      def initialize(faraday_response, params = nil)
        raise RakutenApi::Error.new('not specified Faraday::Response') unless faraday_response.kind_of? ::Faraday::Response
        @status = faraday_response.status
        @body = json_parse(faraday_response.body)
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

        @request_params.add_param :page, @page + 1
        new_request
      end

      def get_prev_page
        nil unless prev?

        @request_params.add_param :page, @page - 1
        new_request
      end

      def new_request
        client = ::RakutenApi::ItemSearch::Client.new
        client.params = @request_params
        client.request
      end

      def parse_body(data)
        p data
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
        @body["Items"].each do |f|
          p f
        end
      end

      protected
        def json_parse(data)
          JSON.parse(data)
        rescue JSON::ParserError
          # @todo logger
          {}
        end
    end
  end
end