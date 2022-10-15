# frozen_string_literal: true

module YoutubeAnalytics
  # Provides access to category data
  class Video
    def initialize(video_data)
      @video = video_data
    end

    def id
      @video['id']
    end

    def published_at
      @video['snippet']['publishedAt']
    end
  end
end
