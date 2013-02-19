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