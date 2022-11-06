# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:categories) do
      primary_key :id
      String      :title, unique: true
      String      :origin_id, unique: true
    end
  end
end
