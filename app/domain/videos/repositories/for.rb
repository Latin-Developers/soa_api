# frozen_string_literal: true

require_relative 'categories'
require_relative 'videos'
require_relative 'authors'
# require_relative 'comment'
# require_relative 'video_log'

module UFeeling
  module Videos
    module Repository
      # Finds the right repository for an entity object or class
      class For
        ENTITY_REPOSITORY = {
          UFeeling::Videos::Entity::Author   => Authors,
          UFeeling::Videos::Entity::Category => Categories,
          UFeeling::Videos::Entity::Video    => Videos
        }.freeze

        def self.klass(entity_klass)
          ENTITY_REPOSITORY[entity_klass]
        end

        def self.entity(entity_object)
          ENTITY_REPOSITORY[entity_object.class]
        end
      end
    end
  end
end
