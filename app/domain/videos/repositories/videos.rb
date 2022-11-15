# frozen_string_literal: true

module UFeeling
  module Videos
    # ? Should this be called Repositories ??
    module Repository
      # Repository for Categories
      class Videos
        def self.find(origin_id)
          find_origin_id(origin_id)
        end

        def self.find_id(id)
          rebuild_entity Database::VideoOrm.first(id:)
        end

        def self.find_title(title)
          rebuild_entity Database::VideoOrm.first(title:)
        end

        def self.find_origin_id(origin_id)
          rebuild_entity Database::VideoOrm.first(origin_id:)
        end

        def self.rebuild_entity(db_record)
          return nil unless db_record

          Entity::Video.new(
            id: db_record.id,
            author_id: db_record.author_id,
            category_id: db_record.category_id,
            origin_id: db_record.origin_id,
            origin_category_id: db_record.origin_category_id,
            origin_author_id: db_record.origin_author_id,
            published_at: db_record.published_at,
            title: db_record.title,
            description: db_record.description,
            thumbnail_url: db_record.thumbnail_url,
            duration: db_record.duration,
            tags: db_record.tags
          )
        end

        def self.rebuild_many(db_records)
          db_records.map do |db_member|
            Videos.rebuild_entity(db_member)
          end
        end

        def self.find_or_create(entity)
          category = category_from_origin_id(entity)
          author = author_from_origin_id(entity)

          entity = UFeeling::Videos::Entity::Video.new(entity.to_h.merge(category_id: category.id,
                                                                         author_id: author.id))

          Database::VideoOrm.find_or_create(entity.to_attr_hash)
        end

        def self.category_from_origin_id(entity)
          category = UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Category)
            .find(entity.origin_category_id)

          unless category
            category = UFeeling::Videos::Mappers::ApiCategory.new(App.config.YOUTUBE_API_KEY)
              .category(entity.origin_category_id)
            category = Database::CategoryOrm.find_or_create(category.to_attr_hash)
          end
          category
        end

        def self.author_from_origin_id(entity)
          author = UFeeling::Authors::Repository::For.klass(UFeeling::Authors::Entity::Author)
            .find(entity.origin_author_id)

          unless author
            author = UFeeling::Authors::Mappers::ApiAuthor.new(App.config.YOUTUBE_API_KEY)
              .author(entity.origin_author_id)
            author = Database::AuthorOrm.find_or_create(author.to_attr_hash)
          end

          author
        end
      end
    end
  end
end
