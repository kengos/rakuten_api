# coding: utf-8

module RakutenApi
  module GenreSearch
    class Model < ::RakutenApi::Base::Model
      include RakutenApi.constantize 'genre_model'

      GENRE_SEARCH_CASTING = {
        "genreId" => Proc.new{|o| o.to_i},
        'genreLevel' => Proc.new{|o| o.to_i}
      }.freeze

      attr_accessor :genre_id
      attr_accessor :genre_name
      attr_accessor :genre_level

      def self.casting
        GENRE_SEARCH_CASTING
      end
    end
  end
end