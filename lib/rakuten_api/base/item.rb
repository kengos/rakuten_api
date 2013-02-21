# coding: utf-8

module RakutenApi::Base
  module Item
    ITEM_CASTING = {
      'smallImageUrls' => Proc.new{|o| o.map{|v| v["imageUrl"]}},
      'mediumImageUrls' => Proc.new{|o| o.map{|v| v["imageUrl"]}},
      'imageFlag' => Proc.new{|o| o == 1},
      'availability' => Proc.new{|o| o == 1},
      'taxFlag' => Proc.new{|o| o == 1},
      'postageFlag' => Proc.new{|o| o == 1},
      'creditCardFlag' => Proc.new{|o| o == 1},
      'shopOfTheYearFlag' => Proc.new{|o| o == 1},
      'shipOverseasFlag' => Proc.new{|o| o == 1},
      'asurakuFlag' => Proc.new{|o| o == 1},
      'giftFlag' => Proc.new{|o| o == 1},
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
    attr_accessor :credit_card_flag
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
  end
end