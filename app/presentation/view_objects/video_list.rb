# frozen_string_literal: true

require_relative 'video'

module Views
  # View for a a list of video entities
  class VideoList
    def initialize(videos)
      @videos = videos.map.with_index { |video, i| Video.new(video, i) }
    end

    def each(&)
      @videos.each(&)
    end

    def any?
      @videos.any?
    end
  end
end
