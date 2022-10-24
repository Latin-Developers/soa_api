# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeAnalytics
  module Entity
    # Provides access to Content Detail data
    class ContentDetail < Dry::Struct
      attribute :duration,         String
      attribute :dimension,        Strict::String
      attribute :definition,       Strict::String
      attribute :caption,          Strict::Integer
      attribute :licensed_content, Strict::Integer
      attribute :projection,       Strict::Integer
    end
  end
end
