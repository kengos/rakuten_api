# coding: utf-8

module RakutenApi
  class Error < ::StandardError
  end

  class ServerError < ::RakutenApi::Error
    attr_reader :status
    def initilize(message, status)
      super(message)
      @status = status
    end
  end
end