# coding: utf-8

module RakutenApi
  module GenreSearch
    class Model < ::RakutenApi::Base::Model
      include RakutenApi.constantize 'genre_model'

      MAPPINGS = {
        "genreId" => ['genre_id', Proc.new{|o| o.to_i}],
        'genreName' => 'genre_name',
        'genreLevel' => ['genre_level', Proc.new{|o| o.to_i}]
      }.freeze

      attr_accessor :genre_id
      attr_accessor :genre_name
      attr_accessor :genre_level

      def self.mapping
        MAPPINGS
      end
    end
  end
end