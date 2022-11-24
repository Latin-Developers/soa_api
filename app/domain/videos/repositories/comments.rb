# frozen_string_literal: true

module UFeeling
  module Videos
    # ? Should this be called Repositories ??
    module Repository
      # Repository for Categories
      class Comments

        def self.find_id(id)
          rebuild_entity Database::CommentsLogOrm.first(id:)
        end

        def self.find_ids(ids)
          ids.filter { |id| id }
            .map { |id| rebuild_entity Database::CommentsLogOrm.first(id:) }
            .filter { |comment| comment }
        end

        def self.rebuild_entity(db_record)
          return nil unless db_record

          Entity::Comment.new(
            id:db_record.id,
            video_id:db_record.video_id,
            author_channel_id:db_record.author_channel_id,
            sentiment_id:db_record.sentiment_id,
            sentimental_score:db_record.sentimental_score,
            text_display:db_record.text_display,
            text_original:db_record.text_original,
            published_at:db_record.published_at,
            like_count:db_record.like_count,
            total_reply_Count:db_record.total_reply_Count,
            day:db_record.day,
            month:db_record.month,
            year:db_record.year
          )
        end

        def self.rebuild_many(db_records)
          db_records.map do |db_member|
            Comments.rebuild_entity(db_member)
          end
        end
        
        def self.find_or_create(entity)
          video = category_from_origin_id(entity)
          author = author_from_origin_id(entity)
          #Missing Sentiment

          entity = UFeeling::Comments::Entity::Comment.new(entity.to_h.merge(video_id: video.id,
                                                                             author_channel_id: author_channel.id))
          Database::CommentsLogOrm.find_or_create(entity.to_attr_hash)
        end

        def self.video_from_origin_id(entity)
          video = UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Video)
            .find(entity.origin_category_id)

          unless video
            video = UFeeling::Videos::Mappers::ApiVideo.new(App.config.YOUTUBE_API_KEY)
              .video(entity.origin_video_id)
              video = Database::VideoOrm.find_or_create(video.to_attr_hash)
          end
          video
        end

        def self.author_channel_from_origin_id(entity)
          author_channel = UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Author)
            .find(entity.origin_author_id)

          unless author
            author_channel = UFeeling::Videos::Mappers::ApiAuthor.new(App.config.YOUTUBE_API_KEY)
              .author(entity.origin_author_id)
            author_channel = Database::AuthorOrm.find_or_create(author.to_attr_hash)
          end
          author
        end
      end
    end
  end
end
