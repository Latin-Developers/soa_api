# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeAnalytics
  module Entity
    # Provides access to comment data
    class VideoComment < Dry::Struct
      include Dry.Types

      attribute :id,                        Integer.optional
      attribute :origin_id,                 Strict::String
      attribute :origin_video_id,           Strict::String
      attribute :text_display,              Strict::String
      attribute :text_original,             Strict::String
      attribute :author_display_name,       Strict::String
      attribute :author_profile_image_url,  Strict::String
      attribute :origin_author_channel_id,  Strict::String
      attribute :can_rate,                  Strict::Bool
      attribute :viewer_rating,             Strict::String
      attribute :like_count,                Strict::Integer
      attribute :published_at,              Strict::String
      attribute :updated_at,                Strict::String
      attribute :can_reply,                 Strict::Bool
      attribute :total_reply_count,         Strict::Integer
      attribute :public,                    Strict::Bool
    end
  end
end
