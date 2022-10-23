# frozen_string_literal: true

module YoutubeAnalytics
  # Provides access to category data
  class Comment
    def initialize(comment_data)
      @comment = comment_data
    end

    def id
      @comment['id']
    end

    def video_id
      @comment['snippet']['videoId']
    end

    def text_display
      @comment['snippet']['textDisplay']
    end
  end
end
