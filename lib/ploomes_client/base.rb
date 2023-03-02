# frozen_string_literal: true

module PloomesClient
  class Base < FHTTPClient::Base
    def self.config
      @config ||= PloomesClient::Configuration.config
    end

    private

    def headers
      {
        'User-Key' => config.user_key,
        'Content-Type' => 'application/json',
        'odata.metadata' => 'minimal'
      }
    end
  end
end
