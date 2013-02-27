# coding: utf-8

module RakutenApi
  module GenreSearch
    class Response < ::RakutenApi::Base::Response
      def initialize(faraday_response = nil)
        super(faraday_response)
      end

      def cache
        @cache ||= {}
      end

      def parents
        return cache['parents'] if cache.key? 'parents'
        return [] unless @body.key? 'parents'
        cache['parents'] = [].tap do |result|
          @body['parents'].each do |f|
            next unless f.include? 'parent'
            result << Model.from_hash(f['parent'])
          end
        end
      end

      def current
        return cache['current'] if cache.key? 'current'
        return nil unless @body.key? 'current'
        cache['current'] = Model.from_hash(@body['current'])
      end

      def children
        return cache['children'] if cache.key? 'children'
        return [] unless @body.key? 'children'
        cache['children'] = [].tap do |result|
          @body["children"].each do |f|
            next unless f.include? 'child'
            result << Model.from_hash(f['child'])
          end
        end
      end
    end
  end
end