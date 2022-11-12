# frozen_string_literal: true

require 'sequel'

module UFeeling
  module Database
    # Object-Relational Mapper for video entities
    class VideoOrm < Sequel::Model(:videos)
      many_to_one   :category,
                    class: :'UFeeling::Database::categories',
                    key: :category_id

      many_to_one   :author,
                    class: :'UFeeling::Database::authors',
                    key: :author_id

      one_to_many   :comments,
                    class: :'UFeeling::Database::comments',
                    key: :video_id

      one_to_many :logs,
                  class: :'UFeeling::Database::videos_log',
                  key: :video_id

      plugin :timestamps, update_on_create: true
    end
  end
end
