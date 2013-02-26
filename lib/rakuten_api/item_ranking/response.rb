# coding: utf-8

module RakutenApi
  module ItemRanking
    class Response < ::RakutenApi::Base::Response
      attr_reader :title
      attr_reader :last_build_date
      attr_reader :page

      def initialize(faraday_response = nil, params = nil)
        super(faraday_response)
        @request_params = params
        parse_body
      end

      def next_ranking
        @request_params['page'] = @page + 1
        new_request
      end

      def prev?
        @page > 1
      end

      def prev_ranking
        return nil unless prev?
        @request_params['page'] = @page - 1
        new_request
      end

      def new_request
        Client.new do |params|
          @request_params.each_pair do |k, v|
            params.add_param k, v
          end
        end.request
      end

      def parse_body
        @title = @body['title']
        @last_build_date = DateTime.rfc2822(@body['lastBuildDate']) rescue nil
        @page = @request_params['page'] if @request_params.is_a? Hash
        @page ||= 1
      end

      def simple_mapping
        [] unless @body.include? "Items"
        [].tap do |result|
          @body["Items"].each do |f|
            next unless f.include? 'Item'
            result << Model.from_hash(f['Item'])
          end
        end
      end
    end
  end
end