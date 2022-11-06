# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeAnalytics
  module Entity
    # Provides access to comment data
    class Comment < Dry::Struct
      include Dry.Types

      attribute :id,                        Integer.optional
      attribute :origin_id,                 Strict::String
      attribute :origin_video_id,           Strict::String
      attribute :text_display,              Strict::String
      attribute :text_original,             Strict::String
      attribute :author_display_name,       Strict::String
      attribute :author_profile_image_url,  Strict::String
      attribute :viewer_rating,             Strict::String
      attribute :like_count,                Strict::Integer
      attribute :published_at,              Strict::String
      attribute :updated_at,                Strict::String
      attribute :comment_replies,           Array.of(Comment)
    end
  end
end
