# frozen_string_literal: false

module YoutubeAnalytics
  module Youtube
    # Data Mapper: Youtube Category -> Category Entity
    class VideoCategoryMapper
      def initialize(youtube_token, gateway_class = Youtube::Api)
        @token = youtube_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def categories(region)
        data_items = @gateway.categories(region)
        data_items.map { |data| VideoCategoryMapper.build_entity(data) }
      end

      def self.build_entity(data)
        DataMapper.new(data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          YoutubeAnalytics::Entity::VideoCategory.new(
            id: nil,
            origin_id:,
            title:
          )
        end

        def origin_id
          @data['id']
        end

        def title
          @data['snippet']['title']
        end
      end
    end
  end
end
