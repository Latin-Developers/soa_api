# frozen_string_literal: true

module UFeeling
  module Videos
    # ? Should this be called Repositories ??
    module Repository
      # Repository for Sentiments
      class Sentiments
        def self.find_id(id)
          rebuild_entity Database::SentimentOrm.first(id:)
        end

        def self.find_title(sentiment)
          rebuild_entity Database::SentimentOrm.first(sentiment:)
        end

        def self.all
          categories = Database::SentimentOrm.all
          rebuild_many(sentiments)
        end

        def self.rebuild_entity(db_record)
          return nil unless db_record

          Entity::Sentiment.new(
            id: db_record.id,
            sentiment: db_record.sentiment
          )
        end

        def self.rebuild_many(db_records)
          db_records.map do |db_member|
            Sentiments.rebuild_entity(db_member)
          end
        end

        def self.find_or_create(entity)
          Database::SentimentOrm.find_or_create(entity.to_attr_hash)
        end
      end
    end
  end
end
