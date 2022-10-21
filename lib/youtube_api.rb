# frozen_string_literal: true

require 'http'
require_relative 'youtube_filters'
require_relative 'youtube_constants'
require_relative 'youtube_category'
require_relative 'youtube_video'
require_relative 'youtube_comment'
require_relative 'youtube_detail'
require_relative 'http_utils/request'

module YoutubeAnalytics
  # Library for Youtube Web API
  class YoutubeAPI
    YOUTUBE_API_PATH = { VIDEO_CATEGORIES: 'videoCategories', VIDEOS: 'videos', COMMENTS: 'commentThreads' }.freeze

    def initialize(token)
      @token = token
    end

    def categories(region)
      youtube_response = HTTPRequest.new(YOUTUBE_API_PATH[:VIDEO_CATEGORIES],
                                         @token,
                                         YoutubeAPIFilters.categories(region))
                                    .youtube_api_http_get
      youtube_response['items'].map { |category_data| Category.new(category_data) }
    end

    def popular_videos(region)
      youtube_response = HTTPRequest.new(YOUTUBE_API_PATH[:VIDEOS],
                                         @token,
                                         YoutubeAPIFilters.popular_videos(region))
                                    .youtube_api_http_get
      youtube_response['items'].map { |video_data| Video.new(video_data) }
    end

    def video_comments(video_id)
      youtube_response = HTTPRequest.new(YOUTUBE_API_PATH[:COMMENTS],
                                         @token,
                                         YoutubeAPIFilters.video_comments(video_id))
                                    .youtube_api_http_get
      youtube_response['items'].map { |comment_data| Comment.new(comment_data) }
    end

    def video_details(video_id)
      youtube_response = HTTPRequest.new(YOUTUBE_API_PATH[:VIDEOS],
                                         @token,
                                         YoutubeAPIFilters.video_details(video_id))
                                    .youtube_api_http_get
      Detail.new(youtube_response['items'].first)
    end
  end
end
