# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeAnalytics
  module Entity
    # Provides access to Thumbnail data
    class Thumbnail < Dry::Struct
      attribute :id,          Integer.optional
      attribute :resolution,  Strict::String
      attribute :url,         Strict::String
      attribute :width,       Strict::Integer
      attribute :height,      Strict::Integer
    end
  end
end
