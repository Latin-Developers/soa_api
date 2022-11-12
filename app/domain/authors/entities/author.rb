# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module UFeeling
  module Authors
    module Entity
      # Provides access to Category data
      class Authors < Dry::Struct
        include Dry.Types

        attribute :id,          Integer.optional
        attribute :name,        Strict::String
        attribute :description, Strict::String
        attribute :country,     Strict::String

        def to_attr_hash
          to_hash.except(:id)
        end
      end
    end
  end
end
