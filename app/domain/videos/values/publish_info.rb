# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module UFeeling
  module Videos
    module Values
      # Publish infos
      class PublishedInfo < Dry::Struct
        include Dry.Types

        attribute :published_at,  Strict::Time
        attribute :year,          Strict::Integer
        attribute :month,         Strict::Integer
        attribute :day,           Strict::Integer

        def to_attr_hash
          to_hash
        end
      end
    end
  end
end
