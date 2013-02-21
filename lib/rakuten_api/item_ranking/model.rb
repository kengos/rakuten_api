# coding: utf-8

module RakutenApi
  module ItemRanking
    class Model < ::RakutenApi::ItemSearch::Model
      include RakutenApi.constantize 'item_ranking_module'
      include ::RakutenApi::Base::Item

      attr_accessor :rank
      attr_accessor :carrier

      def self.casting
        ITEM_CASTING
      end
    end
  end
end