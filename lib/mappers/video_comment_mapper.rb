# frozen_string_literal: false

module YoutubeAnalytics
  module Youtube
    # Data Mapper: Youtube Video -> Entity Video
    class VideoCommentMapper
      def initialize(youtube_token, gateway_class = Youtube::Api)
        @token = youtube_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def video_comments(video_id)
        data_items = @gateway.video_comments(video_id)
        data_items.map { |data| build_entity(data) }
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
          YoutubeAnalytics::Entity::VideoComment.new(
            id: nil,
            origin_id:,
            origin_video_id:,
            text_display:,
            text_original:,
            author_display_name:,
            author_profile_image_url:,
            origin_author_channel_id:,
            can_rate:,
            viewer_rating:,
            like_count:,
            published_at:,
            updated_at:,
            can_reply:,
            total_reply_count:,
            public: public?
          )
        end

        def origin_id
          @data['id']
        end

        def origin_video_id
          @data['snippet']['videoId'] if @data['snippet']
        end

        def comment
          @data['snippet']['topLevelComment']['snippet'] if contains_comment?
        end

        def text_display
          comment['textDisplay'] if contains_comment?
        end

        def text_original
          comment['textOriginal'] if contains_comment?
        end

        def author_display_name
          comment['authorDisplayName'] if contains_comment?
        end

        def author_profile_image_url
          comment['authorProfileImageUrl'] if contains_comment?
        end

        def origin_author_channel_id
          comment['authorChannelId']['value'] if contains_author_channel_id?
        end

        def can_rate
          comment['canRate'] if contains_comment?
        end

        def viewer_rating
          comment['viewerRating'] if contains_comment?
        end

        def like_count
          comment['likeCount'] if contains_comment?
        end

        def published_at
          comment['publishedAt'] if contains_comment?
        end

        def updated_at
          comment['updatedAt'] if contains_comment?
        end

        def can_reply
          @data['snippet']['canReply'] if contains_comment?
        end

        def total_reply_count
          @data['snippet']['totalReplyCount'] if contains_comment?
        end

        def public?
          @data['snippet']['isPublic'] if contains_comment?
        end

        def contains_comment?
          @data['snippet'] && @data['snippet']['topLevelComment'] && @data['snippet']['topLevelComment']['snippet']
        end

        def contains_author_channel_id?
          contains_comment? && comment['authorChannelId']
        end
      end
    end
  end
end
