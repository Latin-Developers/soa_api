# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:videos) do
      primary_key :id
      foreign_key :author_id, :authors
      foreign_key :category_id, :categories
      String      :origin_id
      DateTime    :published_at
      String      :description
      String      :thumbnail_url
      String      :tags
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
