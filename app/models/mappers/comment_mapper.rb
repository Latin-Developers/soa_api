# frozen_string_literal: false

module UFeeling
  module Youtube
    # Data Mapper: Youtube Video -> Entity Video
    class CommentMapper
      def initialize(youtube_token, gateway_class = Youtube::Api)
        @token = youtube_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@token)
      end

      def comments(video_id)
        data_items = @gateway.comments(video_id)
        data_items.map { |data| CommentMapper.build_entity(data) }
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
          UFeeling::Entity::Comment.new(
            id: nil,
            origin_id:,
            origin_video_id:,
            text_display:,
            text_original:,
            author_display_name:,
            author_profile_image_url:,
            viewer_rating:,
            like_count:,
            published_at:,
            updated_at:,
            comment_replies:
          )
        end

        private

        def origin_id
          @data['id']
        end

        def origin_video_id
          top_level_comment_snippet['videoId']
        end

        def text_display
          top_level_comment_snippet['textDisplay']
        end

        def text_original
          top_level_comment_snippet['textOriginal']
        end

        def author_display_name
          top_level_comment_snippet['authorDisplayName']
        end

        def author_profile_image_url
          top_level_comment_snippet['authorProfileImageUrl']
        end

        def viewer_rating
          top_level_comment_snippet['viewerRating']
        end

        def like_count
          top_level_comment_snippet['likeCount']
        end

        def published_at
          top_level_comment_snippet['publishedAt']
        end

        def updated_at
          top_level_comment_snippet['updatedAt']
        end

        def comment_replies
          replies_comments.map { |replies_comment| CommentMapper.build_entity(replies_comment) }
        end

        def replies
          @data['replies'] || {}
        end

        def replies_comments
          replies['comments'] || []
        end

        def snippet
          @data['snippet'] || {}
        end

        def top_level_comment
          snippet['topLevelComment'] || {}
        end

        def top_level_comment_snippet
          top_level_comment['snippet'] || snippet
        end

        def author_channel_id
          top_level_comment_snippet['authorChannelId'] || {}
        end
      end
    end
  end
end
