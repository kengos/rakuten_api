# coding: utf-8

module RakutenApi
  class Response
    attr_reader :status
    attr_reader :body

    def initialize(faraday_response = nil)
      raise RakutenApi::Error.new('not specified Faraday::Response') if !faraday_response.nil? && !faraday_response.kind_of?(::Faraday::Response)
      @status = faraday_response.status
      @body = json_parse(faraday_response.body)
    end

    def success?
      @status == 200
    end

    def error?
      !success?
    end

    protected

    def json_parse(data)
      JSON.parse(data)
    rescue JSON::ParserError
      # @todo logger
      {}
    end
  end
end