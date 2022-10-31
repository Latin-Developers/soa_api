# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeAnalytics
  module Entity
    # Provides access to category data
    class VideoCategory < Dry::Struct
      include Dry.Types

      attribute :id,        Coercible::Integer.optional
      attribute :origin_id, Strict::String
      attribute :title,     Strict::String
    end
  end
end
