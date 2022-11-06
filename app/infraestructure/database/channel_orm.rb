# frozen_string_literal: true

require 'sequel'

module YoutubeAnalytics
  module Database
    # Object Relational Mapper for channel entities
    class ChannelOrm < Sequel::Model(:channels)
      one_to_many :videos,
                  class: :'YoutubeAnalytics::Database::VideoOrm',
                  key: :channel_id

                  :comments_log,
                  class: :'YoutubeAnalytics::Database::CommentsLogOrm',
                  key: :author_channel_id

      plugin :timestamps, update_on_create: true
    end
  end
end
