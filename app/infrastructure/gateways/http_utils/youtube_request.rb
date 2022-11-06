# frozen_string_literal: true

require_relative 'response'

# Sends out HTTP requests to Youtube
class YoutubeHttpRequest
  YOUTUBE_API_ROOT = 'https://www.googleapis.com/youtube/v3'

  def initialize(resource_path, token, query_fields = {})
    @resource_path = resource_path
    @token = token
    @query_fields = query_fields
  end

  def http_get
    http_response = HTTP.get(http_get_uri)

    Response.new(http_response).tap do |response|
      raise(response.error) unless response.successful?
    end

    http_response.parse
  end

  private

  def http_get_uri
    query_fields = @query_fields.reduce('') { |previous, (key, value)| "#{previous}&#{key}=#{value}" }
    "#{YOUTUBE_API_ROOT}/#{@resource_path}?key=#{@token}#{query_fields}"
  end
end
