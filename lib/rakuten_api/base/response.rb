# coding: utf-8

module RakutenApi::Base
  class Response
    require 'json'
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

    def error_message
      nil if success?
      message = ''
      message += @body['error'] + ': ' if @body.include? 'error'
      message += @body['error_description'] if @body.include? 'error_description'
      message == '' ? 'no error message' : message;
    end

    protected

    def json_parse(data)
      ::JSON.parse(data)
    rescue ::JSON::ParserError
      # @todo logger
      {}
    end
  end
end