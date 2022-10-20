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

    def videoId
      @comment['snippet']['videoId']
    end

    def textDisplay
      @comment['snippet']['textDisplay']
    end
  end
end
