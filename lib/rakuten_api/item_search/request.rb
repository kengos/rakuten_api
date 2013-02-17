# coding: utf-8

module RakutenApi
  module ItemSearch
    class Request
      def initialize(application_id = nil, affiliate_id = nil)
        init_params(application_id, affiliate_id)
        yield @params if block_given?
      end

      def get
        connection.get('/services/api/IchibaItem/Search/20120723', @params.to_hash)
      end

      def connection
        @connection ||= new_connection
      end

      def new_connection
        ::Faraday.new(url: 'https://app.rakuten.co.jp/') do |faraday|
          faraday.request  :url_encoded
          faraday.adapter  Faraday.default_adapter
        end
      end

      def add_param(name, value)
        @params[name] = value
      end

      def params
        @params.to_hash
      end

      def init_params(application_id, affiliate_id)
        @params = ::RakutenApi::ItemSearch::Request::Params.new(application_id, affiliate_id)
      end

      class Params < ::RakutenApi::RequestParams
        VALID_NAMES = %w(keyword shopCode genreId hits page sort minPrice maxPrice availability field
          carrier imageFlag orFlag NGKeyword purchaseType shipOverseasFlag shipOverseasArea
          asurakuFlag asurakuArea pointRateFlag pointRate postageFlag creditCardFlag itemCode
          giftFlag hasReviewFlag maxAffiliateRate minAffiliateRate hasMovieFlag
          pamphletFlag appointDeliveryDateFlag elements
        ).freeze

        def valid_names
          @@valid_names ||= (VALID_NAMES + BASE_VALID_NAMES).freeze
        end
      end
    end
  end
end