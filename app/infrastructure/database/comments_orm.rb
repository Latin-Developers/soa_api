# frozen_string_literal: true

require 'sequel'

module UFeeling
  module Database
    # Object-Relational Mapper for comment logs entities
    class CommentsLogOrm < Sequel::Model(:comments)
      many_to_one :video,
                  class: :'UFeeling::Database::VideoOrm',
                  key: :video_id

      many_to_one :channel,
                  class: :'UFeeling::Database::ChannelOrm',
                  key: :author_channel_id

      plugin :timestamps, update_on_create: true
    end
  end
end
