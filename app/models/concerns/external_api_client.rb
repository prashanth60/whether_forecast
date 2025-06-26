# frozen_string_literal: true

require 'httparty'

module ExternalApiClient
  extend ActiveSupport::Concern

  included do
    include HTTParty
    default_timeout 10
    headers "User-Agent" => "weather-enterprise-app@example.com"
    format :json
  end

  class_methods do
    # Makes a GET request and returns parsed JSON or nil
    def get_json(url, query_params = {})
      response = get(url, query: query_params)

      return response.parsed_response if response.success?

      Rails.logger.warn("API call to #{url} failed with status #{response.code}")
      nil
    rescue StandardError => e
      Rails.logger.error("External API request failed: #{e.message}")
      nil
    end
  end
end
