# coding: utf-8

module RakutenApi
  module GenreSearch
    class Model
      include RakutenApi.constantize 'genre_model'

      MAPPINGS = {
        "genreId" => 'genre_id',
        'genreName' => 'genre_name',
        'genreLevel' => 'genre_level'
      }.freeze

      attr_accessor :genre_id
      attr_accessor :genre_name
      attr_accessor :genre_level

      def to_hash
        {}.tap do |h|
          instance_variables.each do |sym|
            h[sym.to_s.tapp.sub('@', '').to_sym] = instance_variable_get(sym)
          end
        end
      end

      def self.from_hash(hash)
        obj = self.new
        MAPPINGS.each_pair do |k, v|
          next unless hash.include?(k)
          obj.send("#{v}=", hash[k])
        end
        obj
      end
    end
  end
end