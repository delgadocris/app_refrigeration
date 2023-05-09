module Refrigeration
  class Api
    include Refrigeration::Authenticator
    include HTTParty

    attr_accessor :id

    base_uri Rails.configuration.refrigeration[:url]

    def initialize(id = 0)
      @id = id
    end

    def setting_request
      { headers: headers }
    end

    def valid_response?(response)
      (200..204).cover?(response.code)
    end

    def logger_exceptions(message, error)
      Rails.logger.info { "#{message}\n - Bugtrace: #{error.backtrace.first(3)&.join("\n")}" }
    end

    private

    def headers
      { 'Content-Type' => 'application/json', 'AUTH-TOKEN' => auth[:token] }
    end
  end
end
