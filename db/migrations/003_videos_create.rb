# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:videos) do
      primary_key :id
      foreign_key :channel_id, :channels
      foreign_key :category_id, :categories
      String      :published_at
      String      :description
      String      :thumbnail_url
      String      :tags
    end
  end
end
