# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeAnalytics
  module Entity
    # Provides access to Statistic data
    class Statistic < Dry::Struct
      attribute :viewCount,     Integer
      attribute :likeCount,     Integer
      attribute :favoriteCount, Integer
      attribute :commentCount,  Integer
    end
  end
end
