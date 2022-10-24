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

    def video_resource(resource_type, filters, resource_class)
      youtube_response = YoutubeHttpRequest.new(YOUTUBE_API_PATH[resource_type], @token, filters)
                                           .http_get
      youtube_response['items'].map { |item| resource_class.new(item) }
    end

    def categories(region)
      video_resource(:VIDEO_CATEGORIES, YoutubeAPIFilters.categories(region), Category)
    end

    def popular_videos(region)
      video_resource(:VIDEOS, YoutubeAPIFilters.popular_videos(region), Video)
    end

    def video_comments(video_id)
      video_resource(:COMMENTS, YoutubeAPIFilters.video_comments(video_id), Comment)
    end

    def video_details(video_id)
      video_resource(:VIDEOS, YoutubeAPIFilters.video_details(video_id), Detail).first
    end
  end
end
