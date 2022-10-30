# frozen_string_literal: true

require 'http'

module YoutubeAnalytics
  module Youtube
    # Library for Youtube Web API
    class Api
      YOUTUBE_API_PATH = { VIDEO_CATEGORIES: 'videoCategories', VIDEOS: 'videos', COMMENTS: 'commentThreads' }.freeze

      def initialize(token)
        @token = token
      end

      def video_resource(resource_type, filters)
        youtube_response = YoutubeHttpRequest.new(YOUTUBE_API_PATH[resource_type], @token, filters)
                                             .http_get
        youtube_response['items']
      end

      def categories(region)
        video_resource(:VIDEO_CATEGORIES, ApiFilters.categories(region))
      end

      def popular_videos(region)
        video_resource(:VIDEOS, ApiFilters.popular_videos(region))
      end

      def video_comments(video_id)
        video_resource(:COMMENTS, ApiFilters.video_comments(video_id))
      end

      def video_details(video_id)
        video_resource(:VIDEOS, ApiFilters.video_details(video_id)).first
      end
    end
  end
end
