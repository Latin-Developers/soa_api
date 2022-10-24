# frozen_string_literal: false

module YoutubeAnalytics
  module Youtube
    # Data Mapper: Youtube -> Entity
    class VideoMapper
      def initialize(youtube_token, gateway_class = Youtube::Api)
        @token = youtube_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def popular_videos(region)
        data_items = @gateway.popular_videos(region)
        data_items.map { |data| build_entity(data) }
      end

      def video_details(video_id)
        data = @gateway.video_details(video_id)
        build_entity(data)
      end

      def build_entity(data)
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

        def published_at
          @data['snippet']['publishedAt'] if @data['snippet']
        end

        def origin_channel_id
          @data['snippet']['channelId'] if @data['snippet']
        end

        def title
          @data['snippet']['title'] if @data['snippet']
        end

        def description
          @data['snippet']['description'] if @data['snippet']
        end

        def thumbnails
          VideoThumbnailMapper.build_entity(@data['snippet']['thumbnails']) if @data['snippet']
        end

        def channel_title
          @data['snippet']['channelTitle'] if @data['snippet']
        end

        def origin_category_id
          @data['snippet']['categoryId'] if @data['snippet']
        end

        def live_broadcast_content
          @data['snippet']['liveBroadcastContent'] if @data['snippet']
        end

        def duration
          @data['contentDetails']['duration'] if @data['contentDetails']
        end

        def dimension
          @data['contentDetails']['dimension'] if @data['contentDetails']
        end

        def definition
          @data['contentDetails']['definition'] if @data['contentDetails']
        end

        def caption
          @data['contentDetails']['caption'] if @data['contentDetails']
        end

        def licensed_content
          @data['contentDetails']['licensedContent'] if @data['contentDetails']
        end

        def projection
          @data['contentDetails']['projection'] if @data['contentDetails']
        end

        def view_count
          @data['statistics']['viewCount'] if @data['statistics']
        end

        def like_count
          @data['statistics']['likeCount'] if @data['statistics']
        end

        def favorite_count
          @data['statistics']['favoriteCount'] if @data['statistics']
        end

        def comment_count
          @data['statistics']['commentCount'] if @data['statistics']
        end
      end
    end
  end
end
