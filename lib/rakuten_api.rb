require "rakuten_api/version"
require "rakuten_api/configuration"
require "rakuten_api/error"
require "rakuten_api/request_params"
require "rakuten_api/item_search/model"
require "rakuten_api/item_search/client"
require "rakuten_api/item_search/response"

module RakutenApi
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

    def application_id
      configuration.application_id
    end

    def affiliate_id
      configuration.affiliate_id
    end

    def given_invalid_params
      configuration.given_invalid_params || :none
    end
  end
end
