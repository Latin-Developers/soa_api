# frozen_string_literal: false

module UFeeling
  module Videos
    module Mappers
      # Data Mapper: Youtube Category -> Category Entity
      class ApiCategory
        def initialize(youtube_token, gateway_class = Youtube::Api)
          @token = youtube_token
          @gateway_class = gateway_class
          @gateway = @gateway_class.new(@token)
        end

        def category(category_id)
          data = @gateway.category(category_id)
          ApiCategory.build_entity(data)
        end

        def categories(region)
          data_items = @gateway.categories(region)
          data_items.map { |data| ApiCategory.build_entity(data) }
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
            UFeeling::Videos::Entity::Category.new(
              id: nil,
              origin_id:,
              title:
            )
          end

          private

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
end
