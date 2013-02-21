# coding: utf-8

module RakutenApi
  module ItemSearch
    class Model < ::RakutenApi::Base::Model
      include RakutenApi.constantize 'item_model'
      include ::RakutenApi::Base::Item

      def self.casting
        ITEM_CASTING
      end
    end

  end
end