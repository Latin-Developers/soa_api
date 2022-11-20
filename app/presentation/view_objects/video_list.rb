# frozen_string_literal: true

require_relative 'video'

module Views
  # View for a a list of project entities
  class VideoList
    def initialize(videos)
      @videos = videos.map.with_index { |proj, i| Project.new(proj, i) }
    end

    def each(&)
      @videos.each(&)
    end

    def any?
      @videos.any?
    end
  end
end
