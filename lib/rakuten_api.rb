require "rakuten_api/version"
require "rakuten_api/configuration"
require "rakuten_api/request_params"
require "rakuten_api/item_search/model"

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
  end
end
