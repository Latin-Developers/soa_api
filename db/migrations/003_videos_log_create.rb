# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:videos_log) do
      primary_key :key

      String      :id
      Integer     :viewCount
      Integer     :likeCount
      Integer     :favoriteCount
      Integer     :commentCount
      DateTime    :dateInfo
      String      :day
      String      :month
      String      :year
      Float       :sentimentalScore

      DateTime :created_at
      DateTime :updated_at
    end
  end
end