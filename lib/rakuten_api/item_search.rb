# coding: utf-8

module RakutenApi
  class ItemSearch
    attr_accessor :app_id
    attr_accessor :affiliate_id

    def initialize(app_id, affiliate_id = nil)
      @app_id = app_id
      @affiliate_id = affiliate_id
      init_params
    end

    def get
      yield self if block_given?
      connection.get('/services/api/IchibaItem/Search/20120723', self.params)
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

    def add_params(name, value)
      @params[name] = value
    end

    def params
      @params.reject!{|k,v| v.nil? }
    end

    def init_params
      @params = {}
      add_params('applicationId', @app_id)
      add_params('affiliateId', @affiliate_id)
    end
  end
end