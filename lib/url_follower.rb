# frozen_string_literal: true

require_relative 'faraday_client'

# Class for following URLs and processing responses.
class UrlFollower
  class << self
    def follow_challenge(path)
      response = get_response(path)
      handle_response(response)
    rescue StandardError => e
      puts "\e[31mError:\e[0m #{e.message}"
    end

    private

    def get_response(path)
      response = connection.get(path)
      JSON.parse(response.body)
    end

    def connection
      FaradayClient.instance.connection
    end

    def handle_response(response)
      if response.key?('follow')
        follow_path = build_follow_path(response['follow'])
        puts "\e[32mFollowing URL:\e[0m #{response['follow']}"

        follow_challenge(follow_path)
      elsif response.key?('message') && response['message'] != 'This is not the end'
        display_result(response)
      else
        puts "\e[31mUnexpected response:\e[0m #{response}"
      end
    end

    def build_follow_path(uri)
      uri = URI(uri)
      uri.path = append_json_extension(uri.path)
      uri.request_uri
    end

    def append_json_extension(path)
      path += '.json' unless path.end_with?('.json')
      path
    end

    def display_result(response_data)
      puts "\e[32mResult:\e[0m #{response_data['message']}"
    end
  end
end