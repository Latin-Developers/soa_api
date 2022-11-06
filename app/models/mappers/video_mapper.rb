# frozen_string_literal: false

module YoutubeAnalytics
  module Youtube
    # Data Mapper: Youtube Video -> Entity Video
    class VideoMapper
      def initialize(youtube_token, gateway_class = Youtube::Api)
        @token = youtube_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def popular_videos(region)
        data_items = @gateway.popular_videos(region)
        data_items.map { |data| VideoMapper.build_entity(data) }
      end

      def details(video_id)
        data = @gateway.details(video_id)
        VideoMapper.build_entity(data)
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
          YoutubeAnalytics::Entity::Video.new(
            id: nil,
            origin_id:,
            published_at:,
            origin_channel_id:,
            title:,
            description:,
            thumbnails:,
            origin_category_id:,
            duration:,
            view_count:,
            like_count:,
            favorite_count:,
            comment_count:
          )
        end

        def origin_id
          @data['id']
        end

        def published_at
          snippet['publishedAt']
        end

        def origin_channel_id
          snippet['channelId']
        end

        def title
          snippet['title']
        end

        def description
          snippet['description']
        end

        def thumbnails
          VideoThumbnailMapper.build_entity(snippet['thumbnails'])
        end

        def origin_category_id
          snippet['categoryId']
        end

        def duration
          content_details['duration']
        end

        def view_count
          statistics['viewCount']
        end

        def like_count
          statistics['likeCount']
        end

        def favorite_count
          statistics['favoriteCount']
        end

        def comment_count
          statistics['commentCount']
        end

        private

        def snippet
          @data['snippet'] || {}
        end

        def content_details
          @data['contentDetails'] || {}
        end

        def statistics
          @data['statistics'] || {}
        end
      end
    end
  end
end
