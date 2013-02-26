# coding: utf-8

module RakutenApi
  module ItemSearch
    class Client < ::RakutenApi::Base::Client
      REQUEST_PATH = "/services/api/IchibaItem/Search/20120723"

      def get
        connection.get(REQUEST_PATH, params)
      end

      def request
        Response.new(get, params.clone)
      end

      def init_params(application_id, affiliate_id)
        @params = Params.new(application_id, affiliate_id)
      end

      class Params < ::RakutenApi::Base::Params
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