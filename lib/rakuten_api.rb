require 'faraday'
require "rakuten_api/version"
require "rakuten_api/dummy_module"
require "rakuten_api/configuration"
require "rakuten_api/base/model"
require "rakuten_api/base/client"
require "rakuten_api/base/params"
require "rakuten_api/base/response"
require "rakuten_api/base/item"
require "rakuten_api/error"

module RakutenApi
  APPLICATION_END_POINT = "https://app.rakuten.co.jp/"
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

    def constantize(name)
      names = config.send(name).split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end

  module ItemSearch
    autoload :Client, 'rakuten_api/item_search/client'
    autoload :Response, 'rakuten_api/item_search/response'
    autoload :Model, 'rakuten_api/item_search/model'
  end

  module ItemRanking
    autoload :Client, 'rakuten_api/item_ranking/client'
    autoload :Response, 'rakuten_api/item_ranking/response'
    autoload :Model, 'rakuten_api/item_ranking/model'
  end

  module GenreSearch
    autoload :Client, 'rakuten_api/genre_search/client'
    autoload :Response, 'rakuten_api/genre_search/response'
    autoload :Model, 'rakuten_api/genre_search/model'
  end
end
