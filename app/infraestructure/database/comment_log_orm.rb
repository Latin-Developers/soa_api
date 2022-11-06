# frozen_string_literal: true

require 'sequel'

module YoutubeAnalytics
  module Database
    # Object-Relational Mapper for comment logs entities
    class CommentsLogOrm < Sequel::Model(:comments_log)
      many_to_one :video,
                  class: :'YoutubeAnalytics::Database::VideoOrm',
                  key: :video_id

      many_to_one :channel,
                  class: :'YoutubeAnalytics::Database::ChannelOrm',
                  key: :author_channel_id

      plugin :timestamps, update_on_create: true
    end
  end
end
