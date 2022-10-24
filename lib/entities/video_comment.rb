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
      attribute :textDisplay,               Strict::String
      attribute :textOriginal,              Strict::String
      attribute :authorDisplayName,         Strict::String
      attribute :authorProfileImageUrl,     Strict::String
      attribute :origin_author_channel_id,  Strict::String
      attribute :can_rate,                  Strict::String
      attribute :viewer_rating,             Strict::String
      attribute :like_count,                Strict::String
      attribute :published_at,              Strict::String
      attribute :updated_aAt,               Strict::String
      attribute :can_reply,                 Strict::String
      attribute :total_reply_count,         Strict::String
      attribute :is_public,                 Strict::String
    end
  end
end
