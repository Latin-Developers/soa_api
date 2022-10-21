# frozen_string_literal: true

require_relative 'response'

# Sends out HTTP requests to Github
class HTTPRequest
  YOUTUBE_API_ROOT = 'https://www.googleapis.com/youtube/v3'

  def initialize(resource_path, token, query_fields = {})
    @resource_path = resource_path
    @token = token
    @query_fields = query_fields
  end

  def youtube_api_http_get
    http_get(YOUTUBE_API_ROOT)
  end

  private

  def http_get(base_url)
    uri = http_get_uri(base_url)
    http_response = HTTP.get(uri)

    Response.new(http_response).tap do |response|
      raise(response.error) unless response.successful?
    end

    http_response.parse
  end

  def http_get_uri(base_url)
    query_fields = @query_fields.reduce('') { |previous, (key, value)| "#{previous}&#{key}=#{value}" }
    "#{base_url}/#{@resource_path}?key=#{@token}#{query_fields}"
  end
end
