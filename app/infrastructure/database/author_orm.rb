# frozen_string_literal: true

require 'sequel'

module UFeeling
  module Database
    # Object Relational Mapper for author entities
    class AuthorOrm < Sequel::Model(:authors)
      one_to_many :videos,
                  class: :'UFeeling::Database::VideoOrm',
                  key: :author_id

      one_to_many :comments,
                  class: :'UFeeling::Database::CommentsOrm',
                  key: :author_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(author_info)
        first(origin_id: author_info[:origin_id]) || create(author_info)
      end
    end
  end
end
