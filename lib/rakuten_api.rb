require "rakuten_api/version"
require "rakuten_api/dummy_module"
require "rakuten_api/configuration"
require "rakuten_api/base/model"
require "rakuten_api/base/client"
require "rakuten_api/base/params"
require "rakuten_api/base/response"

require "rakuten_api/error"
require "rakuten_api/item_search/client"
require "rakuten_api/item_search/response"
require "rakuten_api/genre_search/client"
require "rakuten_api/genre_search/response"
require "rakuten_api/item_ranking/client"

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
end

require "rakuten_api/genre_search/model"
require "rakuten_api/item_search/model"

