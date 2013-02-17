# coding: utf-8

require 'json'

module RakutenApi
  module ItemSearch
    class Response
      attr_reader :status
      attr_reader :body
      attr_reader :request_url
      attr_reader :hits
      attr_reader :count
      attr_reader :first
      attr_reader :last
      attr_reader :carrier
      attr_reader :page_count

      def initialize(faraday_response, params = nil)
        raise RakutenApi::Error.new('not specified Faraday::Response') unless faraday_response.is_a ::Faraday::Response
        @status = faraday_response.status
        @body = json_parse(faraday_response.body)
        parse_body(@body)
        @request_url = faraday_response.url
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
        client = ::RakutenApi::ItemSearch::Request.new
        client.params = @request_params
        client.request
      end

      def get_prev_page
        nil unless prev?

        @request_params.add_param :page, @page - 1
        client = ::RakutenApi::ItemSearch::Request.new
        client.params = @request_params
        client.request
      end

      def parse_body(data)
        @count = data['count']
        @page = data['page']
        @last = data['last']
        @hits = data['hits']
        @carrier = data['carrier']
        @page_count = data['pageCount']
      end

      def parse_body
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