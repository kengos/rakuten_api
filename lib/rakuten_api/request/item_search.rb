# coding: utf-8

module RakutenApi
  module Request
    class ItemSearch < Base
      VALID_NAMES = Set.new(
        %w(keyword shopCode genreId hits page sort minPrice maxPrice availability field
          carrier imageFlag orFlag NGKeyword purchaseType shipOverseasFlag shipOverseasArea
          asurakuFlag asurakuArea pointRateFlag pointRate postageFlag creditCardFlag itemCode
          giftFlag hasReviewFlag maxAffiliateRate minAffiliateRate hasMovieFlag
          pamphletFlag appointDeliveryDateFlag elements
        )
      ).freeze

      def valid_names
        VALID_NAMES + BASE_VALID_NAMES
      end
    end
  end
end