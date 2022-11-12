# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:categories) do
      primary_key :id
      String      :title, unique: false
      String      :origin_id, unique: true
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
