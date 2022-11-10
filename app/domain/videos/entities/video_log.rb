# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

require_relative 'video_thumbnail'

module UFeeling
  module Videos
    module Entity
      # Provides access to Category data
      class VideoLog < Dry::Struct
        include Dry.Types

        attribute :id,                   Integer.optional
        attribute :video_id,             Integer.optional
        attribute :view_count,           Integer.optional
        attribute :like_count,           Integer.optional
        attribute :favorite_count,       Integer.optional
        attribute :comment_count,        Integer.optional
        attribute :date,                 Integer.optional
        attribute :month,                Integer.optional
        attribute :year,                 Integer.optional
        attribute :sentimental_score,    Float.optional

        def to_attr_hash
          to_hash.except(:id)
        end
      end
    end
  end
end
