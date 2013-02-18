# coding: utf-8

module RakutenApi
  class RequestParams
    BASE_VALID_NAMES = %w(applicationId affiliateId).freeze
    attr_accessor :given_invalid_params

    def initialize(application_id = nil, affiliate_id = nil)
      init_params application_id || RakutenApi.application_id, affiliate_id || RakutenApi.affiliate_id
      @given_invalid_params = RakutenApi.given_invalid_params
    end

    def init_params(application_id, affiliate_id)
      @params = {}
      add_param('applicationId', application_id)
      add_param('affiliateId', affiliate_id)
    end

    def add_param(name, value)
      _name = normalize(name)
      if valid_name?(_name)
        @params[_name] = value
      else
        if @given_invalid_params == :raise
          raise ::RakutenApi::Error.new('given invalid param: ' + name.to_s)
        elsif @given_invalid_params == :stdout
          puts "Warning: " + name.to_s + ' is invalid name'
        end
      end
    end

    def inspect
      @params
    end

    def [](name)
      _name = normalize(name)
      @params[_name]
    end

    def []=(name, value)
      add_param(name, value)
    end

    def to_hash
      @params ||= {}
      @params.reject!{|k,v| v.nil? }
      @params
    end

    def valid_name?(name)
      valid_names.include? name
    end

    def normalize(name)
      name = name.to_s
      name = name.split('_').tap{|names| break names.shift + names.map(&:capitalize).join } if name =~ /.+\_.+/
      name
    end

    def valid_names
      BASE_VALID_NAMES
    end
  end
end