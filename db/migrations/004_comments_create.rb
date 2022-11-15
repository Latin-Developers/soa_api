# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:comments) do
      primary_key :id
      foreign_key :video_id, table: :videos
      foreign_key :author_author_id, table: :authors
      String      :text_display
      String      :text_original
      DateTime    :published_at
      Integer     :like_count
      Integer     :total_reply_Count
      String      :day
      String      :month
      String      :year
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
