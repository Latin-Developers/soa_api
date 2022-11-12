# frozen_string_literal: true

require_relative 'authors'
# require_relative 'videos'
# require_relative 'author'
# require_relative 'comment'
# require_relative 'video_log'

module UFeeling
  module Authors
    module Repository
      # Finds the right repository for an entity object or class
      class For
        ENTITY_REPOSITORY = {
          UFeeling::Authors::Entity::Author => Authors
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
