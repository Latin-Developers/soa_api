# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:videos) do
      primary_key :key

      String      :id, unique: true
      String      :publishedAt
      String      :channelId
      String      :description
      String      :thumbnailsUrl
      String      :tags
      String      :categoryId
      
    end
  end
end
