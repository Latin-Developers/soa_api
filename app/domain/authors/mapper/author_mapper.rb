# frozen_string_literal: false

module UFeeling
  module Authors
    module Mappers
      # Data Mapper: Youtube Author -> Author Entity
      class ApiAuthor
        def initialize(youtube_token, gateway_class = Youtube::Api)
          @token = youtube_token
          @gateway_class = gateway_class
          @gateway = @gateway_class.new(@token)
        end

        def author(author_id)
          data = @gateway.author(author_id)
          ApiAuthor.build_entity(data)
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
            UFeeling::Authors::Entity::Author.new(
              id: nil,
              origin_id:,
              name:,
              description:
            )
          end

          private

          def origin_id
            @data['id']
          end

          def name
            @data['snippet']['title']
          end

          def description
            @data['snippet']['description']
          end
        end
      end
    end
  end
end
