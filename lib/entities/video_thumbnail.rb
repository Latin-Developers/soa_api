# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeAnalytics
  module Entity
    # Provides access to Thumbnail data
    class VideoThumbnail < Dry::Struct
      include Dry.Types

      attribute :id,          Integer.optional
      attribute :resolution,  String
      attribute :url,         Strict::String
      attribute :width,       Integer
      attribute :height,      Integer
    end
  end
end
