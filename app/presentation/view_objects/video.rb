# frozen_string_literal: true

module Views
  # View for a single video entity
  class Video
    def initialize(video, index = nil)
      @video = video
      @index = index
    end

    def entity
      @video
    end

    def thumbnail_url
      @video.thumbnail_url
    end

    def title
      @video.title
    end
  end
end
