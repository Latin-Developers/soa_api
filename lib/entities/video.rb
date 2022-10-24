# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

require_relative 'video_thumbnail'

module YoutubeAnalytics
  module Entity
    # Provides access to Category data
    class Category < Dry::Struct
      include Dry.Types

      attribute :id,                      Integer.optional
      attribute :origin_id,               Strict::String
      attribute :published_at,            Strict::String
      attribute :origin_channel_id,       Strict::String
      attribute :title,                   Strict::String
      attribute :description,             Strict::String
      attribute :thumbnails,              VideoThumbnail
      attribute :channel_title,           Strict::String
      attribute :origin_category_id,      Integer
      attribute :live_broadcast_content,  Strict::String
      attribute :duration,                String
      attribute :dimension,               Strict::String
      attribute :definition,              Strict::String
      attribute :caption,                 Strict::Integer
      attribute :licensed_content,        Strict::Integer
      attribute :projection,              Strict::Integer
      attribute :view_count,              Integer
      attribute :like_count,              Integer
      attribute :favorite_count,          Integer
      attribute :comment_count,           Integer
    end
  end
end
