# coding: utf-8

module RakutenApi
  class ItemSearch

    def initialize(application_id = nil, affiliate_id = nil)
      init_params(application_id, affiliate_id)
    end

    def get
      yield @params if block_given?
      connection.get('/services/api/IchibaItem/Search/20120723', @params.get)
    end

    def connection
      @connection ||= new_connection
    end

    def new_connection
      ::Faraday.new(url: 'https://app.rakuten.co.jp/') do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

    def add_param(name, value)
      @params[name] = value
    end

    def params
      @params.params
    end

    def init_params(application_id, affiliate_id)
      @params = ::RakutenApi::Request::ItemSearch.new(application_id, affiliate_id)
    end
  end
end