# coding: utf-8

module RakutenApi
  module ItemRanking
    class Response < ::RakutenApi::Base::Response
      attr_reader :title
      attr_reader :last_build_date
      attr_reader :genre_id
      attr_reader :sex
      attr_reader :age
      attr_reader :carrier
      attr_reader :page
      attr_reader :period

      def initialize(faraday_response = nil, params = nil)
        super(faraday_response)
        @request_params = params
        parse_body
      end

      def parse_body
      end
    end
  end
end