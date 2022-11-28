# frozen_string_literal: true

require 'dry/monads'

module UFeeling
  module Services
    # Retrieves array of all listed videos entities
    class ListVideos
      include Dry::Monads::Result::Mixin

      def call(videos_list)
        videos = Repository::For.klass(Entity::Video)
          .find_full_names(videos_list)

        Success(videos)
      rescue StandardError
        Failure('Could not access database')
      end
    end
  end
end
