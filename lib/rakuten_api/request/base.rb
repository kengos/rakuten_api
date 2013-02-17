# coding: utf-8

require 'set'
module RakutenApi
  module Request
    class Base
      BASE_VALID_NAMES = Set.new(['applicationId', 'affiliateId']).freeze

      def initialize(application_id = nil, affiliate_id = nil)
        @application_id = application_id || RakutenApi.application_id
        @affiliate_id = affiliate_id || RakutenApi.affiliate_id
        init_params
      end

      def init_params
        @params = {}
        add_param('applicationId', @application_id)
        add_param('affiliateId', @affiliate_id)
      end

      def add_param(name, value)
        _name = normalize(name)
        if valid_name?(_name)
          @params[_name] = value
        else
          puts "Warning: " + name.to_s + ' is invalid name'
        end
      end

      def inspect
        @params
      end

      def to_s
        params
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
      end
      alias :values :to_hash

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
end