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

    def praise_link
      "/video/#{fullname}"
    end

    def index_str
      "video[#{@index}]"
    end

    def contributor_names
      @video.contributors.map(&:username).join(', ')
    end

    def owner_name
      @video.owner.username
    end

    def fullname
      "#{owner_name}/#{name}"
    end

    def http_url
      @video.http_url
    end

    def name
      @video.name
    end
  end
end
