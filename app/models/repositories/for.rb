# frozen_string_literal: true

require_relative 'categories'
# require_relative 'channel'
# require_relative 'comment'
# require_relative 'video'
# require_relative 'video_log'

module YoutubeAnalytics
  module Repository
    # Finds the right repository for an entity object or class
    module For
      ENTITY_REPOSITORY = {
        Entity::Category => Categories
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
