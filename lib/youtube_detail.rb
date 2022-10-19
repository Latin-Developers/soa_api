# frozen_string_literal: true

module YoutubeAnalytics
  # Provides access to category data
  class Detail
    def initialize(detail_data)
      @detail = detail_data
    end

    def id
      @detail['id']
    end

    def description
      @detail['snippet']['publishedAt']
    end
  end
end
