# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

require_relative 'youtube_thumbnail'
require_relative 'youtube_content_detail'
require_relative 'youtube_statistic'

module YoutubeAnalytics
  module Video
    # Provides access to Category data
    class Category < Dry::Struct
      attribute :id,                      Integer.optional
      attribute :origin_id,               Strict::String
      attribute :published_at,            Strict::String
      attribute :origin_channel_id,       Strict::String
      attribute :title,                   Strict::String
      attribute :description,             Strict::String
      attribute :thumbnails,              Thumbnail
      attribute :channel_title,           Strict::String
      attribute :origin_category_id,      Integer
      attribute :live_broadcast_content,  Strict::String
      attribute :content_details,         ContentDetail
      attribute :statistics,              Statistic
    end
  end
end
