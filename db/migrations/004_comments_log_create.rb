# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:comments_log) do
      primary_key :key

      String      :videoId
      String      :id
      String      :textDisplay
      String      :textOriginal
      String      :authorChannelId
      DateTime    :publishedAt
      DateTime    :UpdatedAt
      Integer     :likeCount
      Integer     :totalReplyCount
      String      :day
      String      :month
      String      :year

    end
  end
end