# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module UFeeling
  module Videos
    module Entity
      # Provides access to Category data
      class Author < Dry::Struct
        include Dry.Types

        attribute :id,            Integer.optional
        attribute :origin_id,     Strict::String
        attribute :name,          Strict::String
        attribute :description,   Strict::String
        attribute :thumbnail_url, Strict::String

        def to_attr_hash
          to_hash.except(:id)
        end
      end
    end
  end
end
