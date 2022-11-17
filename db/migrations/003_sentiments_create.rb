# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:sentiments) do
      primary_key :id
      String      :sentiment, unique: false
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
