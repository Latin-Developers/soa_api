# frozen_string_literal: true

module YoutubeAnalytics
  # Provides access to category data
  class Category
    def initialize(category_data)
      @category = category_data
    end

    def id
      @category['id']
    end

    def title
      @category['snippet']['title']
    end
  end
end
