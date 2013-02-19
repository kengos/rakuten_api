# coding: utf-8

module RakutenApi
  class Configuration
    # rakuten application_id (You can get from https://webservice.rakuten.co.jp/app/create)
    attr_accessor :application_id
    # rakuten affiliate_id
    attr_accessor :affiliate_id
    # behavior when passed an invalid params
    attr_accessor :invalid_params_action
    # RakutenApi::GenreSearch::Model include Module
    attr_accessor :genre_model
    # RakutenApi::ItemSearch::Model include Module
    attr_accessor :item_model

    def initialize
      @application_id = nil
      @affiliate_id = nil
      @invalid_params_action = :stdout
      @genre_model = '::RakutenApi::DummyModule'
      @item_model = '::RakutenApi::DummyModule'
    end
  end
end