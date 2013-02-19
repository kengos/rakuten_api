# coding: utf-8

module RakutenApi
  module ItemSearch
    class Model < ::RakutenApi::Base::Model
      include RakutenApi.constantize 'item_model'

      MAPPINGS = {
        "itemName" => 'item_name',
        'catchcopy' => 'catchcopy',
        'itemCode' => 'item_code',
        'itemPrice' => 'item_price',
        'itemCaption' => 'item_caption',
        'itemUrl' => 'item_url',
        'affiliateUrl' => 'affiliate_url',
        'smallImageUrls' => ['small_image_urls', Proc.new{|o| o.map{|v| v["imageUrl"]}}],
        'mediumImageUrls' => ['medium_image_urls', Proc.new{|o| o.map{|v| v["imageUrl"]}}],
        'imageFlag' => ['image_flag', Proc.new{|o| o == 1}],
        'availability' => ['availability', Proc.new{|o| o == 1}],
        'taxFlag' => ['tax_flag', Proc.new{|o| o == 1}],
        'postageFlag' => ['postage_flag', Proc.new{|o| o == 1}],
        'creditCardFlag' => ['creadit_card_flag', Proc.new{|o| o == 1}],
        'shopOfTheYearFlag' => ['shop_of_the_year_flag', Proc.new{|o| o == 1}],
        'shipOverseasFlag' => ['ship_overseas_flag', Proc.new{|o| o == 1}],
        'asurakuFlag' => ['asuraku_flag', Proc.new{|o| o == 1}],
        'giftFlag' => ['gift_flag', Proc.new{|o| o == 1}],
        'shipOverseasArea' => 'ship_overseas_area',
        'asurakuClosingTime' => 'asuraku_closing_time',
        'asurakuArea' => 'asuraku_area',
        'affiliateRate' => 'affiliate_rate',
        'startTime' => 'start_time',
        'endTime' => 'end_time',
        'reviewCount' => 'review_count',
        'reviewAverage' => 'review_average',
        'pointRate' => 'point_rate',
        'pointRateStartTime' => 'point_rate_start_time',
        'pointRateEndTime' => 'point_rate_end_time',
        'shopName' => 'shop_name',
        'shopCode' => 'shop_code',
        'shopUrl' => 'shop_url',
        'genreId' => 'genre_id'
      }.freeze

      attr_accessor :item_name
      attr_accessor :catchcopy
      attr_accessor :item_code
      attr_accessor :item_price
      attr_accessor :item_caption
      attr_accessor :item_url
      attr_accessor :affiliate_url
      attr_accessor :small_image_urls
      attr_accessor :medium_image_urls

      attr_accessor :availability
      attr_accessor :image_flag
      attr_accessor :tax_flag
      attr_accessor :postage_flag
      attr_accessor :creadit_card_flag
      attr_accessor :shop_of_the_year_flag
      attr_accessor :ship_overseas_flag
      attr_accessor :asuraku_flag
      attr_accessor :gift_flag

      attr_accessor :ship_overseas_area
      attr_accessor :asuraku_closing_time
      attr_accessor :asuraku_area
      attr_accessor :affiliate_rate
      attr_accessor :start_time
      attr_accessor :end_time
      attr_accessor :review_count
      attr_accessor :review_average
      attr_accessor :point_rate
      attr_accessor :point_rate_start_time
      attr_accessor :point_rate_end_time
      attr_accessor :shop_name
      attr_accessor :shop_code
      attr_accessor :shop_url
      attr_accessor :genre_id

      def self.mapping
        MAPPINGS
      end
    end

  end
end