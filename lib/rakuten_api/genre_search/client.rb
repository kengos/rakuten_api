# coding: utf-8

module RakutenApi
  module GenreSearch
    class Client < RakutenApi::Base::Client
      REQUEST_PATH = "/services/api/IchibaGenre/Search/20120723"

      def get
        connection.get(REQUEST_PATH, params)
      end

      def request
        ::RakutenApi::GenreSearch::Response.new(get)
      end

      # get rakuten root genres
      # @param [String] application_id
      # @param [String] affiliate_id
      # @return [Array<RakutenApi::GenreSearch::Model>] 
      def self.root_categories(application_id = nil, affiliate_id = nil)
        response = self.new(application_id, affiliate_id) do |params|
          params.add_param :genre_id, 0
        end.request
        raise RakutenApi::ServerError.new($response.error_message, $response.status) if response.error?
        response.children
      end

      def init_params(application_id, affiliate_id)
        @params = ::RakutenApi::GenreSearch::Client::Params.new(application_id, affiliate_id)
      end

      class Params < ::RakutenApi::Base::Params
        VALID_NAMES = %w(genreId genrePath).freeze

        def valid_names
          @@valid_names ||= (VALID_NAMES + BASE_VALID_NAMES).freeze
        end
      end
    end
  end
end