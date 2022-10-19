# frozen_string_literal: true

require 'http'
require_relative 'youtube_category'
require_relative 'youtube_video'
require_relative 'youtube_comment'

module YoutubeAnalytics
  # Library for Youtube Web API
  class YoutubeApi
    YOUTUBE_API_ROOT = 'https://www.googleapis.com/youtube/v3'
    YOUTUBE_API_PATH = { VIDEO_CATEGORIES: 'videoCategories', VIDEOS: 'videos', COMMENTS: 'commentThreads' }.freeze
    REGIONS = { TAIWAN: 'TW', MEXICO: 'MX', GUATEMALA: 'GT', NICARAGUA: 'NI' }.freeze
    VIDEOS_ID = {VIDEO_ID: 'UYm0kfnRTJk'}.freeze

    module Errors
      class NotFound < StandardError; end
      class BadRequest < StandardError; end
      class Unauthorized < StandardError; end
    end

    HTTP_ERROR = {
      400 => Errors::BadRequest,
      404 => Errors::NotFound
    }.freeze

    def initialize(token)
      @youtube_token = token
    end

    def categories
      categories_url = produce_youtube_api_path(YOUTUBE_API_PATH[:VIDEO_CATEGORIES],
                                                { regionCode: REGIONS[:GUATEMALA] })
      youtube_response = call_youtube_api(categories_url).parse
      youtube_response['items'].map { |category_data| Category.new(category_data) }
    end

    def videos
      videos_url = produce_youtube_api_path(YOUTUBE_API_PATH[:VIDEOS],
                                           { regionCode: REGIONS[:GUATEMALA], part: 'snippet', chart: 'mostPopular' })
      youtube_response = call_youtube_api(videos_url).parse
      youtube_response['items'].map { |video_data| Video.new(video_data) }
    end

    def comments 
      comments_url = produce_youtube_api_path(YOUTUBE_API_PATH[:COMMENTS],
                                             { videoId: VIDEOS_ID[:VIDEO_ID], part: 'snippet,replies' })
      youtube_response = call_youtube_api(comments_url).parse
      youtube_response['items'].map { |comment_data| Comment.new(comment_data) }
    end

    private

    def produce_youtube_api_path(path, args = {})
      query_fields = args.reduce('') { |previous, (key, value)| "#{previous}&#{key}=#{value}" }
      "#{YOUTUBE_API_ROOT}/#{path}?key=#{@youtube_token}#{query_fields}"
    end

    def call_youtube_api(url)
      result = HTTP.get(url)

      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end
