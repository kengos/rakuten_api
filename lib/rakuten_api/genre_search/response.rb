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
        return cache['parents'] if cache.include? 'parents'
        [] unless @body.include? 'parents'
        cache['parents'] = [].tap do |result|
          @body['parents'].each do |f|
            next unless f.include? 'parent'
            result << Model.from_hash(f['parent'])
          end
        end
      end

      def current
        return cache['current'] if cache.include? 'current'
        return Model.new unless @body.include? "current"
        cache['current'] = Model.from_hash(@body['current'])
      end

      def children
        return cache['children'] if cache.include? 'children'
        [] unless @body.include? "children"
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