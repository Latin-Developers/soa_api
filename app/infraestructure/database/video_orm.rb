# frozen_string_literal: true

require 'sequel'

module YoutubeAnalytics
  module Database
    # Object-Relational Mapper for video entities
    class VideoOrm < Sequel::Model(:videos)
      many_to_one   :category,
                    class: :'YoutubeAnalytics::Database::categories',
                    key: :category_id

                    :channel,
                    class: :'YoutubeAnalytics::Database::channels',
                    key: :channel_id

      one_to_many   :comments,
                    class: :'YoutubeAnalytics::Database::comments_log',
                    key: :video_id

                    :videos_log,
                    class: :'YoutubeAnalytics::Database::videos_log',
                    key: :video_id  

      plugin :timestamps, update_on_create: true
    end
  end
end
