# frozen_string_literal: true

require 'faraday'
require 'singleton'

# Singleton class providing a Faraday HTTP connection.
class FaradayClient
  include Singleton
  BASE_URL = "https://www.letsrevolutionizetesting.com".freeze

  def connection
    @connection ||= Faraday.new(
      BASE_URL,
      request: { timeout: 5 },
      headers: { 'Content-Type' => 'application/json' },
    )
  end
end
