# frozen_string_literal: true

require 'sequel'

module YoutubeAnalytics
  module Database
    # Object-Relational Mapper for categories entities
    class CategoryOrm < Sequel::Model(:categories)
      one_to_many :videos,
                  class: :'YoutubeAnalytics::Database::VideoOrm',
                  key: :category_id

      plugin :timestamps, update_on_create: true
    end
  end
end
