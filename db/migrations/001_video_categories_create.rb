# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:video_categories) do
      primary_key :key

      String      :id, unique: true
      String      :title, unique: true

    end
  end
end