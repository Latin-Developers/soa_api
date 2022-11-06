# frozen_string_literal: true

require 'sequel'

module YoutubeAnalytics
  module Database
    # Object-Relational Mapper for videos logs entities
    class VideoLogOrm < Sequel::Model(:videos_log)
      many_to_one :video,
                  class: :'YoutubeAnalytics::Database::VideoOrm',
                  key: :video_id

      plugin :timestamps, update_on_create: true
    end
  end
end
