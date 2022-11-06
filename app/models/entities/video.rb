# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

require_relative 'video_thumbnail'

module UFeeling
  module Entity
    # Provides access to Category data
    class Video < Dry::Struct
      include Dry.Types

      attribute :id,                      Integer.optional
      attribute :origin_id,               Strict::String
      attribute :published_at,            Strict::String
      attribute :origin_channel_id,       Strict::String
      attribute :title,                   Strict::String
      attribute :description,             Strict::String
      attribute :thumbnails,              Array.of(VideoThumbnail)
      attribute :origin_category_id,      Strict::String
      attribute :duration,                String.optional
      attribute :view_count,              Strict::String.optional
      attribute :like_count,              Strict::String.optional
      attribute :favorite_count,          Strict::String.optional
      attribute :comment_count,           Strict::String.optional

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end
