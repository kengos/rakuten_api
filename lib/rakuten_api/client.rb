# coding: utf-8

module RakutenApi
  class Client
    def initialize(application_id = nil, affiliate_id = nil)
      init_params(application_id, affiliate_id)
      yield @params if block_given?
    end

    def init_params(application_id, affiliate_id)
      raise "not implemented"
    end

    def get
      raise "not implemented"
    end

    def request
      raise "not implemented"
    end

    def connection
      @connection ||= new_connection
    end

    def params
      @params.to_hash
    end

    def add_param(name, value)
      @params[name] = value
    end

    def new_connection
      ::Faraday.new(url: ::RakutenApi::APPLICATION_END_POINT) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end