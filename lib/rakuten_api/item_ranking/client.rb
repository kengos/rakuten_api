# coding: utf-8

module RakutenApi
  module ItemRanking
    class Client < ::RakutenApi::Base::Client
      REQUEST_PATH = "/services/api/IchibaItem/Ranking/20120927"

      def get
        connection.get(REQUEST_PATH, params)
      end

      def init_params(application_id, affiliate_id)
        @params = Params.new(application_id, affiliate_id)
      end

      class Params < ::RakutenApi::Base::Params
        VALID_NAMES = %w(genreId age sex carrier page period).freeze

        def valid_names
          @@valid_names ||= (VALID_NAMES + BASE_VALID_NAMES).freeze
        end
      end
    end
  end
end